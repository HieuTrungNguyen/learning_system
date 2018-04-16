class Admin::UsersController < ApplicationController
  before_action :logged_in_user, :verify_admin
  before_action :load_user, except: [:new, :create, :index]

  def index
    params[:search] ||= ""
    @users = User.find_all_users.search_user(params[:search])
      .paginate page: params[:page], per_page: Settings.user.per_page
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".deleted", name: @user.name
    else
      flash[:danger] = t ".not_deleted", name: @user.name
    end
    redirect_to admin_users_url
  end

  private
  def load_user
    @user = User.find_by id: params[:id]
    render_404 unless @user
  end
end
