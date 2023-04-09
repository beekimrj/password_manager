# == Schema Information
#
# Table name: entries
#
#  id             :bigint           not null, primary key
#  title          :string
#  username       :string
#  password       :string
#  url            :string
#  notes          :string
#  data           :jsonb
#  entryable_type :string           not null
#  entryable_id   :bigint           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Entry < ApplicationRecord
  encrypts :title, :username, :url, :notes, :data, deterministic: true
  encrypts :password
  validates :password,  presence: true, allow_blank: false, length: { minimum: 8, maximum: 18 }, confirmation: true

  validates_presence_of :title, :username, :url
  belongs_to :entryable, polymorphic: true
end
