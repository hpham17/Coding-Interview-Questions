class DogsController < ApplicationController
  def index
    @dogs = Dog.all
  end
  def show
    @dog = Dog.find(params[:id])
    @schedule = @dog.schedule.first
    @event = @schedule.events.new
  end
  def create
    dog = Dog.create(dog_params)
    render json: present_dog(dog), status: :created
  end

  private
  def dog_params
    params.require(:dog).permit(:name)
  end

  def present_dog(dog)
    {
      id: dog.id,
      name: dog.name
    }
  end
end
