class VenuesController < ApplicationController

  def show
    @venue = Venue.find_by(id: params[:id])
    @events = @venue.open_events
  end
end
