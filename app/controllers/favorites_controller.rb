class FavoritesController < ApplicationController

  def create
  end

  def destroy
  end

  def checked
    @checked = Favorite.find_by(user_id: set_current_user.id, zillow_id: params[:zillow_id])
    # # return status based on if data exists or not
    if @checked
      render :nothing => true, :status => 200
    else
      render :nothing => true, :status => 404
    end
  end

end
