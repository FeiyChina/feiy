class OrganizationsController < ApplicationController
  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)
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
    organization_params = params.require(:organization).permit(:name, :problem, :description, :website)
    @organization = Organization.find(params[:id])
    @organization.update(organization_params)
    # redirect_to organization_path(@organization)
  end

  def destroy
    organization_params = params.require(:organization).permit(:name, :problem, :description, :website)
    @organization = Organization.find(params[:id])
    @organization.destroy
    redirect_to root_path
    # redirect_to dashboard_path
  end
end
