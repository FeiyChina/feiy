class PagesController < ApplicationController

  def home
    @organizations = Organization.all
  end

end
