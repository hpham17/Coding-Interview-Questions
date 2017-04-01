class SchedulesController < ApplicationController
  def show
    @dog = Dog.find(params[:dog_id])
    render json: @dog.schedule.first.events
  end
end
