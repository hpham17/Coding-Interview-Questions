require 'rails_helper'
require 'date'

RSpec.describe "create events" do
  let!(:dog) { Dog.create(name: "Duke") }

  describe "it sets up correctly" do
    it "has a schedule" do
      expect(dog.schedule).not_to eql []
    end
  end

  describe "create events for dog's schedule" do
    before(:each) do
      @schedule = dog.schedule.first
    end
    it "rollsback if start_time >= end_time" do
      Event.create schedule_id: @schedule.id, start_time: DateTime.now, end_time: DateTime.now - 2, event_type: 'Walk'
      expect(Event.count).to eq 0
    end
    it "rollsback if times overlap" do
      @date = DateTime.now
      @event1 = Event.create schedule_id: @schedule.id, start_time: @date, end_time: @date + 100, event_type: 'Walk'
      @event2 = Event.create schedule_id: @schedule.id, start_time: @date + 4, end_time: @date + 50, event_type: 'Walk'
      expect(Event.count).to eq 1
    end
    it "successfully creates events" do
      @event1 = Event.create schedule_id: @schedule.id, start_time: DateTime.now, end_time: DateTime.now + 2, event_type: 'Walk'
      @event2 = Event.create schedule_id: @schedule.id, start_time: DateTime.now + 3, end_time: DateTime.now + 6, event_type: 'Walk'
      expect(Event.count).to eq 2
    end
  end
end
