class ApplicationMailer < ActionMailer::Base
  default from: Settings.mailer.sent_mail
  layout "mailer"
end
