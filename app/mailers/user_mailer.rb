class UserMailer < ApplicationMailer
  def account_activation customer
    @customer = customer
    mail to: customer.email, subject: t("mail_subject_actived")
  end

  def password_reset customer
    @customer = customer
    mail to: customer.email, subject: t("password_mail_reset")
  end
end
