class VenuesController < ApplicationController
  def show
    @venue = Venue.find_by(id: params[:id])
    possible_event_ids = Event.where(venue_id: @venue.id).uniq.map {|event| event.id}
    @items = Item.available.active.where.not(id: session[:cart]).where(event_id: possible_event_ids)
    @events = @items.map {|item| item.event }.uniq
  end
end
