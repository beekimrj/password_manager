class User < ApplicationRecord
  before_save :downcase_email
  validate :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true, uniqueness: true, case_sensitive: false

  private

  def downcase_email
    self.email = email.downcase
  end
end
