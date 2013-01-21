class Notifier < ActionMailer::Base
  default from: "from@example.com"

  def booking(user_email,user_name, order)
  	@order = order
  	@user_name = user_name
    mail to: user_email, subject: "booking confirmed "
  end

  def cancellation(user_email, user_name, order)
    @order = order
    @user_name = user_name
    mail to: user_email, subject: 'booked order cancelled'
  end


end
