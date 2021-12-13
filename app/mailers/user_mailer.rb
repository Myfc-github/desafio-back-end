class UserMailer < ApplicationMailer
  def welcome_email(user, call_to_action)
    @call_to_action = call_to_action

    mail(subject: "Seja bem-vindo à Fintera!", to: user.email)
  end
end
