class Admin::CategoriesController < ApplicationController
  before_action :load_category, except: [:new, :create, :index]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t ".created"
      redirect_to [:admin, @category]
    else
      flash.now[:danger] = t ".not_created"
    end
  end

  def index
    params[:search] ||= ""
    @categories = Category.all_categories(params[:search])
      .paginate page: params[:page], per_page: Settings.category.per_page
  end

  def show
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t ".updated", name: @category.name
    else
      flash[:danger] = t ".not_updated", name: @category.name
    end
    redirect_to admin_categories_path
  end

  def destroy
    if @category.destroy
      flash[:success] = t ".deleted", name: @category.name
    else
      flash[:danger] = t ".not_deleted", name: @category.name
    end
    redirect_to admin_categories_path
  end

  private
  def category_params
    params.permit :name, :description
  end

  def load_category
    @category = Category.find_by id: params[:id]
    render_404 unless @category
  end
end
