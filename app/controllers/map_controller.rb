class MapController < ApplicationController

  def index
    @address      = params[:address]
  end

  def favorite
    @favorite = Favorite.new
    @favorite.user_id   = set_current_user.id
    @favorite.zillow_id = params[:zillow_id]
    @favorite.address   = params[:address]
    @favorite.save
    render nothing: true, :status => "success"
  end

  def delete_favorite
    @favorite = Favorite.find_by(zillow_id: params[:zillow_id])
    @favorite.destroy
    render nothing: true, :status => "not found"
  end

end
