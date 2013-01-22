class OrdersController < ApplicationController

  # [FIXME_CR] Below mentioned two lines not needed after ApplicationController#4 changes
  layout 'public'
  skip_before_filter :admin_authorize

  before_filter :user_authorize

  def index
    # [FIXME_CR] not sure why below three lines are there.
    # [FIXME_CR] It seems below mentioned is a part of OrderController#show not of OrderController#index
  	@order = Order.current_user_open_order(current_user.id)

    # [FIXME_CR] order total should be return by order model
    @order.amount = order_amount(@order.line_items)
    @order.save
  	respond_to do |format|
  	  format.html
  	end
  end

  # [FIXME_CR] Visitor should be able to add items to cart
  def create
    # [FIXME_CR] Below mentioned is not an order creation.
    # should be moved to LineItemController create or a new action named add_line_item_to_order
    # logic written under add_line_item should be moved to model
    @order = Order.current_user_open_order(current_user.id)
    @order = add_line_item(@order, params[:id],params[:price])
    respond_to do |format|
      if @order.save
        # [FIXME_CR] Message should be more appropriate e.g. "Product one" added successfully to you cart.
        flash[:notice] = 'Added to order'
      else
        # [FIXME_CR] Message should be more appropriate.
        # Should let user know what wrong exacly going on. e.g "Product One" is out of stock etc.
        flash[:error] = 'invalid addition to order'
      end
      format.html { redirect_to request.referrer }
    end
  end

  def confirm
    # [FIXME_CR] extract Order.find(params[:id]) into a before_filter. DRY (do not repeat yourself)
    @order = Order.find(params[:id])
  end

  def update
    # [FIXME_CR] extract Order.find(params[:id]) into a before_filter. DRY (do not repeat yourself)
    @order = Order.find(params[:id])
    if @order.update_attributes(params[:order])
      flash.now[:success] = 'order details updated '
    else
      # [FIXME_CR] Message should be more appropriate.
      # Should let user know what wrong exacly going on. e.g "Product One" is out of stock etc.
      flash.now[:error] = 'error updating order'
    end  
    render :action =>  'confirm' 
  end

  def pay
    # [FIXME_CR] you are using Order.find(params[:id]) in a number of actions. Any reason of not extracting this into a before filter. 
    # Also use rails 3ish syntex where. I think find is DEPRICATED in rails 4. I am not sure but.
    @order = Order.find(params[:id])
    respond_to do |format|
      # [FIXME_CR] Not sure what exactly credit_to_admin method is doing
      if @order.pay & credit_to_admin(@order.amount, @order.user)
        # [FIXME_CR] Should be a part of after Order create/update callback (move to Order model).
        # Controller should handle only request
        Notifier.booking(current_user.email, current_user.username ).deliver
        # [FIXME_CR] any reason of not using redirect_to path, :flash => { }
        flash[:success] = 'Payment made successfully!'
        format.html { redirect_to user_path(current_user) }
      else
        # [FIXME_CR] any reason of not using redirect_to path, :flash => { }
        flash[:error] = 'Invalid details to place an order !'
        format.html { redirect_to request.referrer }
      end
    end
  end

  # [FIXME_CR] This should be part of orders index action.
  # Orders listing should be handeled by by index action if possible.
  def booked
    # [FIXME_CR] should be somthing like current_user.orders.booked
    @orders = Order.user_orders(current_user.id,'booked')
    respond_to do |format|
      format.html
    end
  end

  # [FIXME_CR] User should not be able to cancel an order.
  def cancel
    # [FIXME_CR] any reason of defining routes for cancel get request?
    if request.post?
      @order = Order.find(params[:id])

      # [FIXME_CR] What if order cencellation fails and order is saved somewhere?
      # Refund to user should be a part of order update callback (cancel). Refund to user on cencellation
      # So, move this to Order model under after_update callback OR under cencel transition callback
      #
      @order.user.wallet += @order.amount
      respond_to do |format|
        # [FIXME_CR] Not sure why we are debiting from admin's wallet on order cancellation (in debit_from_admin).
        # If still needed should be a part of order update callback (if status changes to cancel)
        if debit_from_admin(@order.amount) & @order.cancel 
          # [FIXME_CR] Move this to Order after_update callback.
          Notifier.cancellation(current_user.email, current_user.username).deliver  
          flash[:notice] = 'Order Cancelled.Credit refunded to wallet !'
        else
          flash[:error]  = 'Order can\'t be cancelled '
        end
        format.html { redirect_to request.referrer }
      end
    else
      @orders = Order.user_orders(current_user.id,'cancel')
    end
  end

 private
  def add_line_item(order, product_id, product_price)
    line_item = order.line_items.find_by_product_id(product_id)
    if line_item.nil?
      line_item = order.line_items.new(:product_id => product_id, :price => product_price)
    end

    # [FIXME_CR] order total calculation should be done in callbacks
    # This will help in not repeating order total calculation code each time order is changes.
    order.amount = order_amount(order.line_items)
    order    
  end
 
  # [FIXME_CR] order_amount should be a part of Order model
  # move to Order model under Order#total_amount
  def order_amount(line_items)
    amount = 0
    line_items.each do |item|
      amount += item.price * item.quantity
      amount += 30
    end
    amount
  end
end