class TransactionsController < ApplicationController
  before_filter :authorize_user
  def index
  	@transactions = get_order_or_user.transactions
  end

  private
    def get_order_or_user
      return Order.find(params[:order]) if params[:order]
      if current_user.admin
        return User.find(params[:user]) if params[:user]
      end
      current_user
    end
end
