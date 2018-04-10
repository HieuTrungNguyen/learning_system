class LessonsController < ApplicationController
  before_action :logged_in_user, :load_lesson

  def create
    @lesson = current_user.lessons.build category_id: params[:category_id],
      user_id: current_user.id
    if @lesson.save
      flash[:success] = t ".create_success"
      redirect_to edit_lesson_path @lesson
    else
      flash[:danger] = @lesson.errors.full_messages
      redirect_to categories_path
    end
  end

  def index
  end

  def edit
    @category_name = @lesson.category_name
  end

  private
  def load_lesson
    @lesson = Lesson.find_by id: params[:id]
    render_404 unless @lesson
  end
end
