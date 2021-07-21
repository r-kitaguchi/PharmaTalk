class PagesController < ApplicationController
  def index
    @q = PharmacistProfile.ransack(params[:q])
  end
end
