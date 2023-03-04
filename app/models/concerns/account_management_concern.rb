module AccountManagementConcern
  extend ActiveSupport::Concern

  CONFIRMATION_TOKEN_EXPIRATION = 10.minutes

  def confirm!
    update!(confirmed_at: Time.current)
  end

  def confirmed?
    confirmed_at.present?
  end

  def generate_email_confirmation_token
    signed_id(expires_in: CONFIRMATION_TOKEN_EXPIRATION, purpose: :confirm_email)
  end

  def unconfirmed?
    !confirmed?
  end
end
