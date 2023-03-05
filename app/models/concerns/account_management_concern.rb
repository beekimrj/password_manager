module AccountManagementConcern
  extend ActiveSupport::Concern

  EMAIL_CONFIRMATION_TOKEN_EXPIRATION = 10.minutes
  PASSWORD_RESET_TOKEN_EXPIRATION = 10.minutes

  def confirm!
    update!(confirmed_at: Time.current)
  end

  def confirmed?
    confirmed_at.present?
  end

  def generate_email_confirmation_token
    signed_id(expires_in: EMAIL_CONFIRMATION_TOKEN_EXPIRATION, purpose: :confirm_email)
  end

  def unconfirmed?
    !confirmed?
  end

  def send_confirmation_email!
    UserMailer.confirmation(self, generate_email_confirmation_token).deliver_now
  end

  def generate_password_reset_token
    signed_id(expires_in: PASSWORD_RESET_TOKEN_EXPIRATION, purpose: :reset_password)
  end

  def send_password_reset_email!
    UserMailer.password_reset(self, generate_password_reset_token).deliver_now
  end
end
