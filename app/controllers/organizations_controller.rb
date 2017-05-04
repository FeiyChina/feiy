class OrganizationsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show

  def index
    @organizations = Organization.where(accepted?: true)

  end

  def search
    @search_one = []
    @category_params = params[:category]
    @search_by_category = Organization.accepted.where(category: @category_params)
    @search_by_category.each do |org|
      @search_one << org.id
    end
    @name_params = params[:name]
    @search_by_name = Organization.accepted.where(name: @name_params)
    @search_by_name.each do |org|
      @search_one << org.id
    end
    @search_total = @search_one.uniq
    @organizations = []
    @search_total.each do |id|
      if Organization.find(id).accepted?
        @organizations.append(Organization.find(id))
      end
    end
    @categories_all = ["", "Education", "Fashion", "Food", "Waste", "Health", "Environment", "Inclusion", "Community"]
  end

  def new
    @organization = Organization.new
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
    authorize @organization = Organization.find(params[:id])
  end

  def update
    authorize @organization = Organization.find(params[:id])
    @organization = Organization.find(params[:id])
    @organization.update(organization_params)
    redirect_to organization_path(@organization)
  end

  def show
    @organization = Organization.find(params[:id])
    @organizations = Organization.where(category: @organization.category)
    if @organizations.any?
      @suggested_organizations_shuffled = @organizations.shuffle[1..3]
    end
    events = @organization.events
    @events = events.where('date >= ?', Date.today).order(date: :asc)
  end

  def destroy
    authorize @organization = Organization.find(params[:id])
    @organization.destroy
    flash[:notice] = "Your organization has been deleted!"
    redirect_to root_path
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
    @sender = current_user
    @organization = Organization.find(params[:organization_id])
    @body = params[:body]
    OrganizationMailer.organization_contact_email(@organization, @sender, @body).deliver
    flash[:notice] = "Your message has been sent!"
    redirect_to organization_path(@organization)
  end

  private

  def search_params
    params.require(:organization).permit(:name, :category)
  end

  def organization_params
    organization_params = params.require(:organization).permit(:name, :problem, :description, :website, :email, :address, :photo, :logo, :category, :user_is_a_representative, :accepted?)
  end
end
