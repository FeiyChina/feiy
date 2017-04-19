class OrganizationsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)
    @organization.user_id = current_user.id
    if @organization.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @organization = Organization.find(params[:id])
  end

  def update
    @organization = Organization.find(params[:id])
    @organization.update(organization_params)
    # redirect_to organization_path(@organization)
  end

  def show
    @organization = Organization.find(params[:id])
  end

  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy
    redirect_to root_path
    # redirect_to dashboard_path
  end

  def add_comment
    @organization = Organization.find(params[:id])
    @organization.update(comment_params)
    redirect_to :action => :show, :id => @organization
  end


  def like
    @organization = Organization.find(params[:id])
    @organization.liked_by current_user
    @likes = @organization.votes_for.size
    #call the show method to re-render the page
    show
  end

  private

  def comment_params
      params.permit(:comment)
  end

  def organization_params
    organization_params = params.require(:organization).permit(:name, :problem, :description, :website, :address, :photo)
  end
end
