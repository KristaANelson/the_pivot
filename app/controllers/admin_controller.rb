class AdminController < ApplicationController
  before_action :authorize
  def index
    if params[:status].nil? || params[:status] == "all"
      @orders = Order.sorted
    else
      @orders = Order.sorted.where("status = ?", params[:status])
    end
  end
end
