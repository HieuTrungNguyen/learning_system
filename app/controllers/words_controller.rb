class WordsController < ApplicationController
  before_action :load_all_categories, only: [:index]
  before_action :logged_in_user, only: [:index, :show]

  def index
    params[:search] ||= ""
    params[:status] ||= Settings.word.filter.first
    @words = Word.in_category(params[:category_id])
      .send(params[:status], current_user.id, params[:search])
      .paginate page: params[:page], per_page: Settings.word.per_page
  end
end
