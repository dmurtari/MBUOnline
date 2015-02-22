class EventsController < ApplicationController
  before_action :signed_in_user
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:edit, :create, :new, :update, :destroy]

  def index
    @events = Event.order("year")
  end

  def show
    @event
  end

  def new
    @event = Event.new
  end

  def edit
  end 

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:success] = "Successfully created new event"
      redirect_to @event
    else
      render :new
    end
  end

  def update
    if @event.update(event_params)
      flash[:success] = "#Event updated"
      redirect_to root_url
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    flash[:warning] = "Event deleted"
    redirect_to root_url
  end

  private

    def event_params
      params.require(:event).permit(:preference_id, :record_id, :semester, :year)
    end

    def set_event
      @event = Event.find(params[:id])
    end

    def admin_user
      unless current_user.admin?
        flash[:warning] = "Sorry, you aren't authorized to perform that action"
        redirect_to root_url
      end 
    end


end
