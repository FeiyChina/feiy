class EventsController < ApplicationController

  def new
    authorize @organization = Organization.find(params[:organization_id])
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.organization = Organization.find(params[:organization_id])

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
    authorize @organization = Organization.find(params[:organization_id])
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
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
    @organization = Organization.find(params[:organization_id])
    @event = Event.find(params[:id])
    @baidumap_url = 'kekus'
    #@baidumap_url = 'http://api.map.baidu.com/staticimage/v2?ak=' + ENV['BAIDU_KEY'] + "&amp;" + 'mcode=666666&center=' + @event.longitude.to_s + ',' + @event.latitude.to_s + '&width=580&height=250&zoom=16'
  end

  def destroy
    authorize @event = Event.find(params[:id])
    @event.destroy
    redirect_to root_path
  end

  private

  def event_params
    params.require(:event).permit(:name, :content, :date, :venue, :register_link, :flyer)
  end
end


