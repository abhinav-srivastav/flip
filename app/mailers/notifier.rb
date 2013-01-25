class Notifier < ActionMailer::Base
  default from: "admin@grab-your-trolley.com"

  def booking(order)
  	@order = order
  	@user_name = @order.user.username
    mail to: @order.user.email, subject: "booking confirmed "
  end

  def cancellation(order)
    @order = order
    @user_name = order.user.username
    mail to: order.user.email, subject: 'booked order cancelled'
  end
end
