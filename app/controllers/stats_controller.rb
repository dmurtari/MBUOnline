class StatsController < ApplicationController

  before_action :correct_user, only: [:index]




  def index
    @youth_lunch = @adult_lunch = @tshirt = @patch = 0
    @shirt_sizes = {}

    Scout.all.each do |scout|
      if scout.scout_lunch
        @youth_lunch += 1 if scout.age <= 12
        @adult_lunch += 1 if scout.age > 12
      end
      @adult_lunch += scout.additional_lunch unless scout.additional_lunch.nil?
      
      if scout.shirt
        @tshirt += 1
        if @shirt_sizes[scout.shirt_size]
          @shirt_sizes[scout.shirt_size] += 1
        else
          @shirt_sizes[scout.shirt_size] = 1
        end
      end
      
      @patch += 1 if scout.patch
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
