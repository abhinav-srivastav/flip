class TransactionsController < ApplicationController
  before_filter :authorize_user
  before_filter :get_order_or_user, :only => :index
  def index
  	@transactions = @order_or_user.transactions
  end

  private
    def get_order_or_user
      table = params[:order] ? 'Order' : 'User'
      @order_or_user = table.constantize.find(params[:order] || params[:user])  
    end
end
