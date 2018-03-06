class UsersController < ApplicationController
  before_action :load_user, except: [:new, :create, :index]
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".welcome"
    else
      render :new
    end
  end

  def show
    render_404 unless @user
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
  end
end
