class UsersController < ApplicationController

  def sign_up
    # this action is just to display sign-up view.
  end

  def create
    @user = User.new(params.require(:user).permit(:username, :email, :password, :password_confirmation, :avatar_url))
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :sign_up
    end
  end



  private

   def user_params
     params.require(:user).permit(:username, :email, :password, :password_confirmation)
   end

end
