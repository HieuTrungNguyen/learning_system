class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find_by id: params[:followed_id]
    current_user.follow @user
    @user.activities.create user_id: current_user.id,
      activity_type: Activity.actions[:follow]
    respond_to do |format|
      format.html {redirect_to @user}
    end
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed
    current_user.unfollow @user
    @user.activities.create user_id: current_user.id,
      activity_type: Activity.actions[:unfollow]
    respond_to do |format|
      format.html {redirect_to @user}
    end
  end
end
