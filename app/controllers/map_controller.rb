class MapController < ApplicationController

  def index
    # @response = Yelp.client.search("1410 NE Campus Parkway, Seattle WA 98195")
  end

  def favorite
    @favorite = Favorite.new
    @favorite.user_id = set_current_user.id
    @favorite.address = params[:address]
    @favorite.save
    render nothing: true
  end

  def delete_favorite
    @favorite = Favorite.find_by(address: params[:address])
    @favorite.destroy
    render nothing: true
  end

end
