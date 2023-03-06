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

  # Module to extend so that we can define class methods.
  module ClassMethods
    # https://stevepolito.design/blog/rails-authentication-from-scratch/#step-17-account-for-timing-attacks
    # This class method serves to find a user using the non-password attributes (such as email), and then authenticates
    # that record using the password attributes. Regardless of whether a user is found or authentication succeeds,
    # authenticate_by will take the same amount of time. This prevents timing-based enumeration attacks,
    # wherein an attacker can determine if a password record exists even without knowing the password.
    def authenticate_by(attributes)
      passwords, identifiers = attributes.to_h.partition do |name, _value|
        !has_attribute?(name) && has_attribute?("#{name}_digest")
      end.map(&:to_h)

      raise ArgumentError, 'One or more password arguements are required' if passwords.empty?
      raise ArgumentError, 'one or more finder arguments are required' if identifiers.empty?

      if (record = find_by(identifiers))
        record if passwords.count { |name, value| record.public_send(:"authenticate_#{name}", value) } == passwords.size
      else
        new(passwords)
        nil
      end
    end
  end

  def self.included(base)
    base.extend ClassMethods
  end
end
