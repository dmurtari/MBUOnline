class PreferencesController < ApplicationController
  before_action :signed_in_user
  before_action :set_preference, only: [:edit, :update]

  def create
    @course = Course.find(params[:scout][:preferences])
    priority = preference_params[:priority]
    event = Event.where(current: true).last
    @scout = Scout.find_by(id: params[:scout_id])

    if @scout.has_preference? @course
      flash[:danger] = "Sorry, can't add preference since that course preference already exists"
    elsif Preference.where(event: event, scout_id: @scout.id).count >= 6
      flash[:danger] = "Sorry, can't add more than 6 preferences"
    else
      priority_check(priority)
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
    priority_check(preference_params[:priority])
    if @preference.update(preference_params)
      if @preference.priority
        flash[:success] = "#{@course.name} is now #{@preference.priority.ordinalize}
                           priority for #{@scout.firstname}"
      else
        flash[:danger] = "#{@course.name} does not have a priority"
      end
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
      @scout = Scout.find(Preference.find(params[:id]).scout_id)
      @course = Course.find(Preference.find(params[:id]).course_id)
    end 

    def priority_check(priority)
      if @scout.has_priority? priority and priority
        flash[:warning] = "A #{priority.to_i.ordinalize} priority course already 
                           exists for #{@scout.firstname}"
      end
    end

end