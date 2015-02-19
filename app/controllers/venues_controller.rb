class VenuesController < ApplicationController

  def show
    @venue = Venue.find_by(id: params[:id])
    @events = Event.active_events(@venue)
  end
end
