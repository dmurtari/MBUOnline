class ScoutsController < ApplicationController
  before_action :signed_in_user
  before_action :set_scout, only: [:edit, :create, :update, :destroy,
                                   :preferred_courses, :show]

  def index
    @scout = Scout.reorder("lastname asc").page(params[:page]).per_page(40)
  end

  def show
    # @scout.calculate_costs
  end

  def new
    @scout = Scout.new
  end

  def edit
  end

  def create
    @scout = current_user.scouts.build(scout_params)
    if @scout.save
      @scout.calculate_costs
      flash[:success] = "#{@scout.firstname} has been registered"
      redirect_to current_user
    else
      render :new
    end
  end

  def update
    if @scout.update(scout_params)
      @scout.calculate_costs
      flash[:success] = "#{@scout.firstname}'s information has been updated"
      redirect_to current_user
    else
      render :edit
    end
  end

  def destroy
    @scout.destroy
    flash[:warning] = "#{@scout.firstname} was deleted"
    redirect_to :back
  end

  def preferred_courses
    @courses = @scout.preferred_courses
    # redirect_to current_user
  end

  private

    def set_scout
      if current_user.admin?
        @scout = Scout.find_by(id: params[:id])
        @admin = true
      else
        @scout = current_user.scouts.find_by(id: params[:id])
      end
    end

    def scout_params
      params.require(:scout).permit(:firstname, :lastname, :dob, :emergency_relation,
                                    :emergency_name, :emergency_phone, :notes,
                                    :preferred_courses, :troop, :scout_lunch,
                                    :additional_lunch, :patch, :shirt, :shirt_size,
                                    :cost)
    end
end
