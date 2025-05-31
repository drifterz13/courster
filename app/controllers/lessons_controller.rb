class LessonsController < ApplicationController
  def new
  end

  def create
    @course = Course.find(params[:course_id])
    @lesson = @course.lessons.build(lesson_params)

    if @lesson.save
      redirect_to course_path(@course), notice: 'Lesson was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @course = Course.find(params[:course_id])
    @lesson = @course.lessons.find(params[:id])

    if !@course.can_delete_by?(Current.user)
      redirect_to course_path(@course), alert: 'You are not authorized to delete this lesson.'
      return
    end

    if @lesson.destroy
      redirect_to course_path(@course), notice: 'Lesson was successfully deleted.'
    else
      redirect_to course_path(@course), alert: 'Failed to delete lesson.'
    end
  end

  private
  
  def lesson_params
    params.require(:lesson).permit(:title, :description)
  end
end
