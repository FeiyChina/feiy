class EventsController < ApplicationController

  # def like
  #   @event = Event.find(params[:id])
  #   @event.liked_by(current_user)
  #   redirect_to event_show_path
  # end

  def new
    @organization = Organization(params[:organization_id])
    @event = Event.new
  end

  def create
    @event = event.new(event_params)
    @event.organization = Organization.find(params[:organization_id])
    @event.save
      redirect_to dashboard_path
  end

  def edit
    @organization = Organization.find(params[:organization_id])
    @event = Event.find(params[:id])
  end


  def update

  end

  def show

  end

  private

  def event_params
    params.require(:event).permit(:name, :content, :date, :venue, :job_type, :task, :requirement, :active )
  end


end



