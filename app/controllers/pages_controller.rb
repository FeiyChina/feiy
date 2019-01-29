class PagesController < ApplicationController
  before_action :authenticate_user!, only: :dashboard

  def home
    @current_user = current_user
    @articles = Article.includes(:tags).published.limit(3)
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
    @filterrific = initialize_filterrific(
      Job.accepted.activated,
      params[:filterrific],
      select_options: {
        job_types: %w(Volunteer Internship Part-time Full-time),
        job_addresses: %w(Shanghai China)
      },
      available_filters: [:with_job_type, :with_job_address]
    ) or return
    @jobs = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def events
    # a scope was defined in model
    @events = Event.accepted.future(Date.today)
  end

end
