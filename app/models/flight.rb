# == Schema Information
#
# Table name: flights
#
#  id          :integer          not null, primary key
#  alert_sent  :boolean          default(FALSE)
#  departs_at  :datetime
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
class Flight < ApplicationRecord
  belongs_to(:user, :required => true)
  validates(:departs_at, { :presence => true })
end
