# == Schema Information
#
# Table name: dogs
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Dog < ActiveRecord::Base
  has_many :schedule
  validates :name, presence:true
  after_create :create_schedule

  private
  def create_schedule
    self.schedule.create!
  end
end
