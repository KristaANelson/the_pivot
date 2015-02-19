class VenuesController < ApplicationController

  def show
    @venue = Venue.find_by(id: params[:id])
    @events = Event.active(@venue)
  end
end
