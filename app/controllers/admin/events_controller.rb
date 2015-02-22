class Admin::EventsController < ApplicationController
  include Admin::ImagesHelper

  before_action :authorize

  def index
    @events = Event.order(updated_at: :desc)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.image = add_image(params[:event][:images])
    @event.category = Category.find(params[:event][:category])
    @event.venue = Venue.find(params[:event][:venue])
    @event.save
    redirect_to admin_events_path
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params)
    update_image(params[:event][:images])
    @event.category = Category.find(params[:event][:category])
    @event.venue = Venue.find(params[:event][:venue])
    @event.save
    redirect_to admin_events_path
  end

  def destroy
    Event.destroy(params[:id])
    redirect_to admin_events_path
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :date, :approved)
  end

end
