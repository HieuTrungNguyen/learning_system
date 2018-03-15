class Admin::CategoriesController < ApplicationController
  before_action :load_category, only: [:show]
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

  def show
  end

  private
  def category_params
    params.require(:category).permit :name, :description
  end

  def load_category
    @category = Category.find_by id: params[:id]
  end
end
