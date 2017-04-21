class PagesController < ApplicationController
  before_action :authenticate_user!, only: :dashboard

  def home
    @current_user = current_user
    @organizations = Organization.all
  end

  def dashboard
    @current_user = current_user
    @organizations = @current_user.organizations
  end

  def eventshow
  end

end
