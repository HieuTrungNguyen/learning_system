class Admin::UsersController < ApplicationController
  before_action :logged_in_user, :verify_admin

  def index
    params[:search] ||= ""
    @users = User.find_all_users.search_user(params[:search])
      .paginate page: params[:page], per_page: Settings.user.per_page
  end
end
