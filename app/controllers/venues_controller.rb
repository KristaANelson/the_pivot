class VenuesController < ApplicationController
  def show
    @venue = Venue.find_by(id: params[:id])
    @items = Item.active.not_in_cart(session[:cart]).joins(:event).where(events: {venue_id: @venue.id})
    @events = @items.map(&:event).uniq
  end
end
