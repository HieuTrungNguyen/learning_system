class WordsController < ApplicationController
  before_action :load_all_categories, only: [:index]
  before_action :logged_in_user, only: [:index, :show]

  def index
    params[:search] ||= ""
    @words = Word.list_words.search_word(params[:search])
      .paginate page: params[:page], per_page: Settings.word.per_page
  end
end
