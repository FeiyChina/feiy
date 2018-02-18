class PagesController < ApplicationController
  before_action :authenticate_user!, only: :dashboard

  def home
    @current_user = current_user
    @articles = Article.includes(:tags).sample(3)
    @organizations = Organization.where(accepted?: true).sample(3)
    @categories_all = ["", "Education", "Fashion", "Food", "Waste", "Health", "Environment", "Inclusion", "Community"]
    # a scope was defined in model
    @jobs = Job.accepted.activated
    # a scope was defined in model
    @events = Event.accepted.future(Date.today)
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
  end

  def jobs
    # a scope was defined in model
    @jobs = Job.accepted.activated
  end

  def events
    # a scope was defined in model
    @events = Event.accepted.future(Date.today)
  end

end
