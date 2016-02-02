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

end
