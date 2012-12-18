class LineItemsController < ApplicationController
  layout 'public'
  skip_before_filter :admin_authorize
  before_filter :user_authorize

  def create 
    
  end

end
