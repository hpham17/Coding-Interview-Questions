# == Schema Information
#
# Table name: schedules
#
#  id         :integer          not null, primary key
#  dog_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Schedule < ActiveRecord::Base
  belongs_to :dog
  has_many :events
  validates :dog_id, presence:true
end
