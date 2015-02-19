class VenuesController < ApplicationController

  def show
    @venue = Venue.find_by(id: params[:id])
    @events = @venue.active_events
  end
end
