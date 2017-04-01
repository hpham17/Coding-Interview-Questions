require 'rails_helper'
require 'date'

RSpec.describe "the schedule API" do
  let!(:dog) { Dog.create(name: "Duke") }

  describe "querying the dog's schedule" do
    it "returns an empty array when there are no items" do
      get "/dogs/#{dog.id}/schedule.json", date: "2017-01-01"

      expect(response.status).to eq 200
      expect(JSON[response.body]).to eq []
    end

    it "returns a list of items that were added to the dog's schedule" do

      # You can modify any of the following code as you make decisions on
      # how to set up and represent data in your system.
      @date = "2017-03-21T21:46:52.000Z"
      @date2 = "2017-03-21T21:46:53.000Z"
      @date3 = "2017-03-21T21:46:54.000Z"
      @date4 = "2017-03-21T21:46:55.000Z"
      post "/events/", :event => {schedule_id: 1, start_time: @date, end_time: @date2, food: "Royal Canin Medium Puppy Dry", event_type: "Mealtime"}

      post "/events/", :event => {schedule_id: 1, start_time: @date3, end_time: @date4, location: "Santa Monica", event_type: "Walk"}

      get "/dogs/#{dog.id}/schedule.json", date: "2017-01-01"

      expect(response.status).to eq 200
      scheduled_events = JSON[response.body]
      expect(scheduled_events.count).to eq 2
      expect(scheduled_events[0]["event_type"]).to eq "Mealtime"
      expect(scheduled_events[0]["start_time"]).to eq @date
      expect(scheduled_events[0]["end_time"]).to eq @date2
      expect(scheduled_events[0]["food"]).to eq "Royal Canin Medium Puppy Dry"

      expect(scheduled_events[1]["event_type"]).to eq "Walk"
      expect(scheduled_events[1]["start_time"]).to eq @date3
      expect(scheduled_events[1]["end_time"]).to eq @date4
      expect(scheduled_events[1]["location"]).to eq "Santa Monica"
    end
  end
end
