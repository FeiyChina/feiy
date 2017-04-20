class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

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
