class Admin::WordsController < ApplicationController
  before_action :logged_in_user, :verify_admin
  before_action :load_word, except: [:new, :create, :index]
  before_action :load_all_categories, except: [:show, :destroy]

  def new
    @word = Word.new
  end

  def create
    @word = Word.new word_params
    if @word.save
      flash[:success] = t ".create_word_success"
      redirect_to @word
    else
      render :new
    end
  end

  def index
    params[:search] ||= ""
    @words = Word.list_words.in_category(params[:category_id])
      .all_words(current_user.id, params[:search])
      .paginate page: params[:page], per_page: Settings.word.per_page
  end

  def show
    @answers = @word.answers
  end

  def edit
  end

  def update
    if @word.update_attributes word_params
      flash[:success] = t ".update_success", name: @word.content
    else
      flash[:info] = t ".update_fail", name: @word.content
    end
    redirect_to [:admin, @word]
  end

  def destroy
    if @word.destroy
      flash[:success] = t ".deleted", name: @word.content
    else
      flash[:info] = t ".deleted_fail", name: @word.content
    end
    redirect_to admin_words_path
  end

  private
  def word_params
    params.require(:word).permit :category_id, :content,
      answers_attributes: [:id, :content, :is_correct, :_destroy]
  end
end
