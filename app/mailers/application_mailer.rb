class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.config.action_mailer.default_options[:from]
  layout "mailer"
end
