class EventsController < ApplicationController
  def create
    @event = Event.new events_params
    if @event.save
      flash[:notice] = "Event saved."
    else
      flash[:error] = "Error event not saved."
    end
    head :ok
  end

  private
  def events_params
    params.require(:event).permit(:schedule_id, :event_type, :start_time, :end_time, :location, :food)
  end
end
