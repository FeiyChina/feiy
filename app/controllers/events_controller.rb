class EventsController < ApplicationController
  before_action :find_event, only: [:edit, :update, :show, :destroy]
  before_action :find_organization, only: [:new, :create, :edit, :show]

  def new
    authorize @organization
    @event = Event.new
  end

  def create
    @event = Event.new(event_params.merge(organization: @organization))

    if @event.save
      MIXPANEL.track(@event.organization_id, 'Created', {
        content: "Event",
        organization_name: @event.organization.name,
        event_name: @event.name,
        venue: @event.venue,
        date: @event.date
      })
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def edit
    authorize @organization
  end

  def update
    @event.update(event_params)

    if @event.save
      MIXPANEL.track(@event.organization_id, 'Update', {
        content: "Event",
        organization_name: @event.organization.name,
        event_name: @event.name,
        venue: @event.venue,
        date: @event.date
      })
      redirect_to dashboard_path
    else
      render :new
    end

  end

  def show
    @baidumap_url = 'http://api.map.baidu.com/staticimage/v2?ak=' + ENV['BAIDU_KEY'] + "&amp;" + 'mcode=666666&center=' + @event.longitude.to_s + ',' + @event.latitude.to_s + '&width=580&height=250&zoom=16'
  end

  def destroy
    authorize @event
    @event.destroy
    redirect_to root_path
  end

  private

  def find_event
    @event = Event.friendly.find(params[:id])
    if params[:id] != @event.slug && params[:id]&.to_i != @event.id
      return redirect_to event_path(@event), status: :moved_permanently
    end
  end

  def find_organization
    @organization = Organization.friendly.find(params[:organization_id])
  end

  def event_params
    params.require(:event).permit(:name, :content, :date, :venue, :register_link, :flyer)
  end
end


