class FollowingsController < ApplicationController
  before_action :load_user, :logged_in_user

  def show
    @following = @user.following
    @users = @following.paginate page: params[:page],
     per_page: Settings.following.per_page
  end
end
