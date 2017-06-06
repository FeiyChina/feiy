class PagesController < ApplicationController
  before_action :authenticate_user!, only: :dashboard

  def home
    @current_user = current_user
    @organizations = Organization.where(accepted?: true)
    @categories_all = ["", "Education", "Fashion", "Food", "Waste", "Health", "Environment", "Inclusion", "Community"]
    @job = Job.all
    @jobs = @job.where(active: true)
    @event = Event.all
    @events = @event.where('date >= ?', Date.today).order(date: :asc)
  end

  def dashboard
    @current_user = current_user
    @organizations = @current_user.organizations
    @organization = @current_user.organizations.first
    @jobs = @organization.jobs
    @events = @organization.events
    @random_comment = @organization.comments.shuffle.first
  end

  def about_us
  end

  def developer
  end

  def eventshow
    @booking = Booking.new
    # @event = Event.find(params[:id])
    # @event.liked_by(current_user)
  end

  def jobs
    # @job = Job.where(Organization accepted?: true)
    @jobs = Job.where(active: true).order(created_at: :desc)#.paginate(:page => params[:page], :per_page => 9)
  end

  def events
    # @event = Event.all
    @events = Event.where('date >= ?', Date.today).order(date: :asc)#.paginate(:page => params[:page], :per_page => 9)
  end

end
