class PreferencesController < ApplicationController
  before_action :set_scout
  before_action :signed_in_user

  def create
    @course = Course.find(params[:scout][:preferences])
    @scout.add_preference!(@course)
    redirect_to current_user
  end

  def destroy
    @course = Preferences.find(params[:id]).course
    @scout.remove_preference!(@course)
    redirect_to current_user
  end

  private

    def set_scout
      @scout = current_user.scouts.first
    end

end