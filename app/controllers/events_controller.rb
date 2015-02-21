class EventsController < ApplicationController
  def index
    @items = Item.active.not_in_cart(session[:cart]).category(params[:category_id])
    @events = @items.map(&:event).uniq
  end

  def show
    @event = Event.find_by(id: params[:id])
    @items = Item.available.active.where.not(id: session[:cart]).where(event_id: @event.id)
  end
end
