class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.sending_password.subject
  #
  def sending_password(user, password)
    @user = user
    @pass = password
    mail to: @user.email, subject: "Provitional Password"
  end
  def forgot_password(user,password)
    @user = user
    @pass = password
    mail to: @user.email, subject: "Provitional Password"
  end
end
