class ActivitiesController < ApplicationController
  before_action :logged_in_user, :load_user

  def index
    @activities = Activity.user_activity(@user.id)
      .paginate page: params[:page], per_page: Settings.activity.per_page
  end
end
