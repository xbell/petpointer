class MapController < ApplicationController

  def index
    # @response = Yelp.client.search("1410 NE Campus Parkway, Seattle WA 98195")
  end

  def favorite
    @favorite = Favorite.new
    @favorite.user_id = set_current_user.id
    @favorite.zillow_id = params[:zillow_id]
    @favorite.save
    render nothing: true, :status => "success"
  end

  def delete_favorite
    @favorite = Favorite.find_by(zillow_id: params[:zillow_id])
    @favorite.destroy
    render nothing: true, :status => "not found"
  end

  

end
