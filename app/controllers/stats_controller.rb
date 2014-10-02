class StatsController < ApplicationController

  before_action :correct_user, only: [:index]




  def index
  end

private

  def correct_user
    unless current_user.admin?
      redirect_to root_url
      flash[:danger] = "Sorry, you aren't authorized to perform that action"
    end
  end



end
