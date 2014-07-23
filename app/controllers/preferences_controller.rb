class PreferencesController < ApplicationController
  before_action :signed_in_user

  def create
    @course = Course.find(params[:scout][:preferences])
    @scout = current_user.scouts.find_by(id: params[:scout_id])
    if @scout.has_preference? @course
      flash[:danger] = "Course preference already exists"
    elsif Preference.where(scout_id: @scout.id).count >= 6
      flash[:danger] = "Sorry, can't add more than 6 preferences"
    else
      @scout.add_preference!(@course)
      flash[:success] = "Added preference #{@course.name}"
    end
    redirect_to edit_scout_path(@scout)
  end

  def destroy
    @course = Course.find(Preference.find(params[:id]).course_id)
    @scout = Scout.find(Preference.find(params[:id]).scout_id)
    if @scout.has_preference? @course
      @scout.remove_preference!(@course)
      flash[:warning] = "Course preference for #{@course.name} was removed"
    else
      flash[:danger] = "Sorry, can't remove preference that doesn't exist"
    end
    redirect_to edit_scout_path(@scout)
  end

end