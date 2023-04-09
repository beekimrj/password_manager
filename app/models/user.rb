# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  confirmed_at    :datetime
#  email           :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  has_secure_password
  include AccountManagementConcern

  attr_accessor :current_password

  has_many :active_sessions, dependent: :destroy
  has_many :entries, as: :entryable

  before_save :downcase_email
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, on: :create }, uniqueness: { case_sensitive: false }

  private

  def downcase_email
    self.email = email.downcase
  end
end
