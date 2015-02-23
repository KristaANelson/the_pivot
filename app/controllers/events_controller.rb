class EventsController < ApplicationController
  def index
    @items = Item.active.not_in_cart(session[:cart])
    @events = @items.map(&:event).uniq
    @events = @events.select { |event| event.category.name == params[:category] } if params[:category]
  end

  def show
    @event = Event.find_by(id: params[:id])
    @items = @event.items.active.not_in_cart(session[:cart])
  end
end
