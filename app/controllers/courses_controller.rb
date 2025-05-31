class CoursesController < ApplicationController
  def index
    @courses = Course.all.order(:created_at)
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    @course.author = Current.user

    if @course.save
      redirect_to courses_path, notice: 'Course was successfully created.'
    else
      render :new
    end
  end

  def show
    @course = Course.find(params[:id])
    @lessons = @course.lessons.order(:order)
  end

  def destroy
    @course = Course.find(params[:id])
    if @course.destroy
      redirect_to courses_path, notice: 'Course was successfully deleted.'
    else
      redirect_to courses_path, alert: 'Failed to delete course.'
    end
  end

  private

  def course_params
    params.require(:course).permit(
      :title,
      :description,
      :lessons_attributes => [:id, :title, :description, :_destroy]
    )
  end
end
