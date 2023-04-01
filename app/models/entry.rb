class Entry < ApplicationRecord
  belongs_to :entryable, polymorphic: true
end
