class RecordsController < ApplicationController
  before_action :signed_in_user
  before_action :set_record, only: [:edit, :update]

  def create
    @course = Course.find(params[:scout][:records])
    @scout = current_user.scouts.find_by(id: params[:scout_id])
    period = record_params[:period]
    if !period
      flash[:danger] = "A period must be provided"
    elsif @scout.has_period? period
      flash[:danger] = "A #{period.to_i.ordinalize} period course for 
                         #{@scout.firstname} already exists"
    elsif !@course.has_room? period
      flash[:danger] = "The #{period.to_i.ordinalize} period for #{@course.name} 
                        is full"
    elsif Record.where(scout_id: @scout.id).count > 3
      flash[:danger] = "Sorry, can't add more than 3 assignments"
    else
      if @scout.add_record!(@course, period) 
        flash[:success] = "Added assignment #{@course.name}"
      else
        flash[:danger] = "Couldn't add assignment. Is the course full?"
      end
    end
    redirect_to edit_scout_path @scout 
  end

  def destroy
    @course = Course.find(Record.find(params[:id]).course_id)
    @scout = Scout.find(Record.find(params[:id]).scout_id)
    if @scout.has_record? @course
      @scout.remove_record! @course
      flash[:warning] = "Course assignment for #{@course.name} was removed"
    else
      flash[:danger] = "Sorry, can't remove an assignment that doesn't exist"
    end
    redirect_to edit_scout_path @scout
  end

  def edit
  end

  def update
  end

  def index
  end
  
  private

    def record_params
      params.require(:record).permit(:course_id, :scout_id, :period)
    end

    def set_record
      @record = Record.find(params[:id])
      @scout = Scout.find(Record.find(params[:id]).scout_id)
      @course = Course.find(Record.find(params[:id]).course_id)
    end 
end