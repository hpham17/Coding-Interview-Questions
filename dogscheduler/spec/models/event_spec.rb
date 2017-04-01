require 'rails_helper'

RSpec.describe Event, type: :model do
  it "rollbacks if it doesnt validate" do
    Event.create
    expect(Event.count).to eq 0
  end
end
