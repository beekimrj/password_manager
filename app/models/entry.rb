class Entry < ApplicationRecord
  encrypts :title, :username, :url, :notes, :data, deterministic: true
  encrypts :password
  validates :password,  presence: true, allow_blank: false, length: { minimum: 8, maximum: 18 }, confirmation: true

  validates_presence_of :title, :username, :url
  belongs_to :entryable, polymorphic: true
end
