# == Schema Information
#
# Table name: dogs
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Dog, type: :model do
  it "can load and save" do
    Dog.create(name: "Lola")
    expect(Dog.count).to eq 1
  end
end
