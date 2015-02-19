class EventsController < ApplicationController
  def index
    require 'pry'; binding.pry
    @events = Event.active
  end

  def show
    @event = Event.find_by(id: params[:id])
    @items = @event.items
  end
end
