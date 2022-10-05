class UserSignUpMailer < ApplicationMailer
  default :from => 'aleyanc2000@gmail.com'

  def send_signup_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Registro Alkemy DisneyAPI' )
  end
end
