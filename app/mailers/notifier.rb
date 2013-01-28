class Notifier < ActionMailer::Base
  default from: "admin@grab-your-trolley.com"

  def booking(order)
  	@order = order
  	@user_name = @order.user.username
    mail to: @order.user.email, subject: "booking confirmed "
  end

  def dispatched(order)
    @order = order
    @user_name = @order.user.username
    mail to: @order.user.email, subject: "order dispatched"
  end

  def delivered(order)
    @order = order
    @user_name = @order.user.username
    mail to: @order.user.email, subject: "order delivered"
  end

  def cancellation(order)
    @order = order
    @user_name = order.user.username
    mail to: order.user.email, subject: 'booked order cancelled'
  end
end
