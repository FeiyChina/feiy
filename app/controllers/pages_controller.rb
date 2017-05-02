class PagesController < ApplicationController
  before_action :authenticate_user!, only: :dashboard

  def home
    @current_user = current_user
    @organizations = Organization.all
    @categories = Category.all
    @job = Job.all
    @jobs = @job.where(active: true)
    @event = Event.all
    @events = @event.where('date >= ?', Date.today).order(date: :asc)

  end

  def dashboard
    @current_user = current_user
    @organizations = @current_user.organizations
    @organization = @current_user.organizations.first
    @categories = Category.all
    @jobs = Job.all
    @events = @organization.events.all
    @random_comment = @organization.comments.shuffle.first
  end

  def about_us
  end

  def eventshow
    @booking = Booking.new
    # @event = Event.find(params[:id])
    # @event.liked_by(current_user)
  end

  def jobspool
    @job = Job.all
    @jobs = @job.where(active: true)
  end

  def events
    @event = Event.all
    @events = @event.where('date >= ?', Date.today).order(date: :asc)
  end

end
