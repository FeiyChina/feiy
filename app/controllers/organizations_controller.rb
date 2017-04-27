class OrganizationsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show

  def new
    @organization = Organization.new
    @categories = Category.all
  end

  def create
    @organization = Organization.new(organization_params)
    @organization.user_id = current_user.id
    if @organization.save
      redirect_to dashboard_path
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
    redirect_to organization_path(@organization)
  end

  def show
    @organization = Organization.find(params[:id])
    @categories = Category.all
    @organizations = Organization.all
    organization_category = @organization.categories.last.name
    @empty_array = []

    @organizations.each do |organization|
      if organization.categories == organization_category
        @empty_array << organization
      end
    end
    if @empty_array.any?
      @empty_array.shuffle[1..3]
    end
  end

  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy
    redirect_to root_path
    # redirect_to dashboard_path
  end

  def like
    @organization = Organization.find(params[:id])
    @organization.liked_by current_user
    @likes = @organization.votes_for.size
    #call the show method to re-render the page
    show
  end

  private

  def organization_params
    organization_params = params.require(:organization).permit(:name, :problem, :description, :website, :address, :photo, :logo, :category_ids, :user_is_a_representative)
  end
end
