class PreferencesController < ApplicationController
  before_action :signed_in_user

  def create
    @course = Course.find(params[:scout][:preferences])
    @scout = current_user.scouts.find_by(id: params[:scout_id])
    @scout.add_preference!(@course)
    redirect_to edit_scout_path(@scout)
  end

  def destroy
    @course = Course.find(Preference.find(params[:id]).course_id)
    @scout = Scout.find(Preference.find(params[:id]).scout_id)
    @scout.remove_preference!(@course)
    redirect_to edit_scout_path(@scout)
  end

end