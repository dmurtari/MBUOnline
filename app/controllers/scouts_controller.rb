class ScoutsController < ApplicationController
  before_action :signed_in_user
  before_action :set_scout, only: [:edit, :create, :update, :destroy]

  def index
    @scout = Scout.paginate(page: params[:page])
  end

  def show
  end

  def new
    @scout = Scout.new
  end

  def edit
  end

  def create
    @scout = current_user.scouts.build(scout_params)
    if @scout.save
      flash[:success] = "#{@scout.firstname} has been registered"
      redirect_to current_user
    else
      flash[:danger] = "Saving scout failed"
      redirect_to current_user
    end
  end

  def update
    if @scout.update(scout_params)
      flash[:success] = "#{@scout.firstname} has been updated"
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

  private

    def set_scout
      @scout = current_user.scouts.find_by(id: params[:id])
    end

    def scout_params
      params.require(:scout).permit(:firstname, :lastname)
    end
end