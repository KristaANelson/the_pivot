class EventsController < ApplicationController
  def index
    @events = Event.active
  end

  def show
    @event = Event.find_by(id: params[:id])
    @items = @event.items
  end
end
