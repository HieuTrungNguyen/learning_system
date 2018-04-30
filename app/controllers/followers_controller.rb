class FollowersController < ApplicationController
  before_action :load_user, :logged_in_user

  def show
    @followers = @user.followers
    @users = @followers.paginate page: params[:page],
      per_page: Settings.follower.per_page
  end
end
