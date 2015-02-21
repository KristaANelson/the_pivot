class Admin::EventsController < ApplicationController
  include Admin::ImagesHelper

  before_action :authorize

  def index
    @events = Event.all
  end

  def edit
    @event = Event.find_by(id: params[:id])
  end

  def update
    @event = Event.find_by(id: params[:id])
    @event.update(event_params)
    update_image(params[:event][:images])
    #update_category(params[:event][:categories])
    @event.save
    redirect_to admin_events_path
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :date, :approved)
  end

end
