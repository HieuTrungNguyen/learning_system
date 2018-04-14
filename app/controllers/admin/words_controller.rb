class Admin::WordsController < ApplicationController
  before_action :load_all_categories, only: [:new, :create]

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

  private
  def word_params
    params.require(:word).permit :category_id, :content,
      answers_attributes: [:content, :is_correct, :_destroy]
  end

  def load_all_categories
    @categories = Category.select :name, :id
  end
end