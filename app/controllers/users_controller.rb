class UsersController < ApplicationController
  before_action :load_user, except: [:new, :create, :index]
  before_action :logged_in_user, except: [:new, :create]
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".welcome"
      redirect_to root_url
    else
      render :new
    end
  end

  def index
    params[:search] ||= ""
    @users = User.find_all_users
      .search_user(params[:search])
      .paginate page: params[:page], per_page: Settings.user.per_page
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".update_success"
    else
      flash[:info] = t ".not_update"
    end
    redirect_to @user
  end

  def show
    render_404 unless @user
    @activities = Activity.user_activity(@user.id).limit(Settings.activity.size)
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :avatar
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless current_user? @user
  end
end
