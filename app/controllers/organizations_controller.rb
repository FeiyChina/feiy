class OrganizationsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show

  def search
    @organizations = Organization.find(search_params)
    @categories = Category.all
  end

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
    # trying to display search results by categories #
    @organizations = Organization.where(:category_ids => "category".to_i)
    @organization = Organization.find(params[:id])
    @categories = Category.all
    @organizations = Organization.all
    if @organization.categories.any?
      organization_category = @organization.categories.last.name
      @suggested_organizations = []

      @organizations.each do |organization|
        if organization.categories == organization_category
          @suggested_organizations << organization
        end
      end
      if @suggested_organizations.any?
        @suggested_organizations.shuffle[1..3]
      end
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
  end

  def organization_contact
    @organization = Organization.find(params[:organization_id])
  end

  def organization_send
    @sender_email = current_user.email
    @message_body = params[:body]
    @organization_email = Organization.find(params[:organization_id])
  end

  private

  def search_params
    params.require(:organization).permit(:name, :id, :category_ids)
  end

  def organization_params
    organization_params = params.require(:organization).permit(:name, :problem, :description, :website, :address, :photo, :logo, :category_ids, :user_is_a_representative)
  end
end
