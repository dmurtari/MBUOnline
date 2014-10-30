class RecordsController < ApplicationController
  before_action :signed_in_user
  before_action :set_record, only: [:edit, :update]

  def create
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
      params.require(:record).permit(:course_id, :scout_id)
    end

    def set_preference
      @record = Record.find(params[:id])
      @scout = Scout.find(Record.find(params[:id]).scout_id)
      @course = Course.find(Record.find(params[:id]).course_id)
    end 

end