class VenuesController < ApplicationController

  def show
    @venue = Venue.find_by(id: params[:id])
    @events = Event.active_events.joins(:items.where.not(id: @cart.cart_items)
  end
end
