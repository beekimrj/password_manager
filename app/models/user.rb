class User < ApplicationRecord
  has_secure_password
  include AccountManagementConcern

  before_save :downcase_email
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, on: :create }, uniqueness: { case_sensitive: false }

  private

  def downcase_email
    self.email = email.downcase
  end
end
