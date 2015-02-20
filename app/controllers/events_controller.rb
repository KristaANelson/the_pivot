class EventsController < ApplicationController
  def index
    @events = Event.active.joins(:items).where.not(id: @cart.cart_items)  
  end

  def show
    @event = Event.find_by(id: params[:id])
    @items = @event.items.where.not(id: @cart.cart_items)
  end
end
