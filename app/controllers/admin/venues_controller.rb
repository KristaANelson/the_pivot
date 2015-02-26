class Admin::VenuesController < ApplicationController
  before_action :authorize
  def index
    @venues = Venue.all
  end

  def edit
    @venue = Venue.find(params[:id])
  end

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.new(venue_params)
    if @venue.location_finder && @venue.save
      redirect_to admin_venues_path
    else
      flash[:errors] = "Invalid location"
      render :new
    end
  end

  def update
    @venue = Venue.find(params[:id])
    @venue.update(venue_params)
    redirect_to admin_venues_path
  end

  def destroy
    venue = Venue.find(params[:id])
    items = Item.active.not_in_cart(session[:cart]).joins(:event).where(events: {venue_id: venue.id})
    if items.empty?
      venue.destroy
    else
      flash[:errors] = "Cannot delete venue with tickets listed"
    end
    redirect_to :back
  end

  private

  def venue_params
    params.require(:venue).permit(:name, :location)
  end
end
