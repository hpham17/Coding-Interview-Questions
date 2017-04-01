# == Schema Information
#
# Table name: schedules
#
#  id         :integer          not null, primary key
#  dog_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Schedule, type: :model do
  it "cannot be created without dog_id" do
    Schedule.create
    expect(Schedule.count).to eq 0
  end
end
