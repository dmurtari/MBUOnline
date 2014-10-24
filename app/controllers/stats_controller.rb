class StatsController < ApplicationController

  before_action :correct_user, only: [:index]




  def index
    @youth_lunch = @adult_lunch = 0
    Scout.all.each do |scout|
      if scout.scout_lunch
        @youth_lunch += 1 if scout.age <= 12
        @adult_lunch += 1 if scout.age > 12
      end
      @adult_lunch += scout.additional_lunch unless scout.additional_lunch.nil?
    end
  end

private

  def correct_user
    unless current_user.admin?
      redirect_to root_url
      flash[:danger] = "Sorry, you aren't authorized to perform that action"
    end
  end



end
