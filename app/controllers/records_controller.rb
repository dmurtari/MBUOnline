class RecordsController < ApplicationController
  before_action :signed_in_user
  before_action :set_record, only: [:edit, :update]

  def create
    @course = Course.find(params[:scout][:record])
    @scout = current_user.scouts.find_by(id: params[:scout_id])
    period = record_params[:period]
    if Record.where(scout_id: @scout.id).count > 3
      flash[:danger] = "Sorry, can't add more than 3 assignments"
    else
      @scout.add_record!(@course, period)
      flash[:success] = "Added assignment #{@course.name}"
    end
    redirect_to edit_scout_path(@scout)
  end

  def destroy
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