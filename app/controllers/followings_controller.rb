class FollowingsController < ApplicationController
  def follow
    @user = User.find(params[:id])
    current_user.followees << @user
    flash[:notice] = "Your are following #{@user.username}"
    redirect_to @user
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.followed_users.find_by(followee_id: @user.id).destroy
    redirect_to user_path(@user)
  end
  
end
