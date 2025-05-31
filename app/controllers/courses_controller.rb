class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

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
    @lessons = @course.lessons.order(:order)
  end

  def edit
  end

  def update
    if @course.update(course_params)
      redirect_to courses_path, notice: 'Course was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if !@course.can_delete_by?(Current.user)
      redirect_to courses_path, alert: 'You are not authorized to delete this course.'
      return
    end

    if @course.destroy
      redirect_to courses_path, notice: 'Course was successfully deleted.'
    else
      redirect_to courses_path, alert: 'Failed to delete course.'
    end
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :description)
  end
end
