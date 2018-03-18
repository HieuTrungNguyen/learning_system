class CategoriesController < ApplicationController
  def index
    params[:search] ||= ""
    @categories = Category.order(created_at: :ASC)
      .all_categories(params[:search]).includes(:words)
      .paginate page: params[:page], per_page: Settings.category.per_page
  end
end
