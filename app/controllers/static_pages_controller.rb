class StaticPagesController < ApplicationController
  def index
  end

  def admin
  end

  def not_found
    redirect_to root_path
  end
end
