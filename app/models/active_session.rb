# == Schema Information
#
# Table name: active_sessions
#
#  id             :bigint           not null, primary key
#  user_id        :bigint           not null
#  user_agent     :string
#  ip_address     :string
#  remember_token :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class ActiveSession < ApplicationRecord
  has_secure_token :remember_token

  belongs_to :user
end
