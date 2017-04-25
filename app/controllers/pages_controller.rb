class PagesController < ApplicationController
  before_action :authenticate_user!, only: :dashboard

  def home
    @current_user = current_user
    @organizations = Organization.all
    @categories = Category.all
    @job = Job.all
    @jobs = @job.where(active: true)
  end

  def dashboard
    @current_user = current_user
    @organizations = @current_user.organizations
    @categories = Category.all
    @jobs = Job.all
  end

  def eventshow
  end

end
