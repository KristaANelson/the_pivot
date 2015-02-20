class EventsController < ApplicationController
  def index
    @items = Item.active.available.where.not(id: session[:cart])
    @events = @items.map(&:event).uniq
  end

  def show
    @event = Event.find_by(id: params[:id])
    @items = Item.available.active.where.not(id: session[:cart]).where(event_id: @event.id)
  end
end
