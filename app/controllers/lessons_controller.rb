class LessonsController < ApplicationController
  before_action :logged_in_user
  before_action :load_lesson, :get_category_name, :correct_user,
    only: [:show, :edit, :update]

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

  def show
  end

  def edit
  end

  def update
    if @lesson.update_attributes lesson_params.merge is_complete: true
      flash[:success] = t ".finished"
      redirect_to @lesson
    else
      flash[:danger] = t ".not_finished"
      redirect_to categories_path
    end
  end

  private
  def load_lesson
    @lesson = Lesson.find_by id: params[:id]
    render_404 unless @lesson
  end

  def lesson_params
    params.require(:lesson).permit results_attributes: [:id, :answer_id]
  end

  def get_category_name
    @category_name = @lesson.category_name
  end

  def correct_user
    redirect_to root_url unless current_user.id == @lesson.user_id
  end
end
