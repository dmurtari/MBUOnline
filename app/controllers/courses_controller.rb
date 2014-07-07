class CoursesController < ApplicationController
  before_action :set_course, only: [:edit, :create, :update, :destroy]

  def index
    @courses = Course.all
  end

  def show
  end

  def new
    @course = Course.new
  end

  def edit
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      flash[:success] = "Course #{@course.name} successfully created"
      redirect_to courses_url
    else
      render :new
    end
  end

  def update
    if @course.update(course_params)
      flash[:success] = "#{@course.name} updated"
    else
      render :edit
    end
  end

  def destroy
    @course.destroy
    flash[:warning] = "#{@course.name} was deleted"
    redirect_to courses_url
  end

  private

    def set_course
      @course = Course.find_by(id: params[:id])
    end

    def course_params
      params.require(:course).permit(:name, :destription, :room)
    end

end