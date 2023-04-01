class Entry < ApplicationRecord
  encrypts :title, :username, :url, :notes, :data, deterministic: true
  encrypts :password

  belongs_to :entryable, polymorphic: true
end
