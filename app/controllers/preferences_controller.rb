class PreferencesController < ApplicationController
  before_action :signed_in_user
  before_action :set_preference, only: [:edit, :update]

  def create
    @course = Course.find(params[:scout][:preferences])
    priority = params[:preference][:priority]
    @scout = current_user.scouts.find_by(id: params[:scout_id])
    if @scout.has_preference? @course
      flash[:danger] = "Course preference already exists"
    elsif Preference.where(scout_id: @scout.id).count >= 6
      flash[:danger] = "Sorry, can't add more than 6 preferences"
    elsif @scout.has_priority? priority
      flash[:danger] = "Sorry, scout already has a preference with that priority"
    else
      @scout.add_preference!(@course, priority)
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

  def edit
  end

  def update
    @scout = Scout.find(Preference.find(params[:id]).scout_id)
    if @preference.update(preference_params)
      flash[:success] = "Successfully changed preference"
      redirect_to edit_scout_path(@scout)
    else
      render :edit
    end
  end
  
  private

    def preference_params
      params.require(:preference).permit(:course_id, :scout_id, :priority)
    end

    def set_preference
      @preference = Preference.find(params[:id])
    end 

end