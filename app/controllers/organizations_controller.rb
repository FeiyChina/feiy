class OrganizationsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show

  def index
    @organizations = Organization.where(accepted?: true)

  end

  def search
    # search by category
    @category_params = params[:category]
    @categories = Category.where(name: @category_params)
    @search_one = []
    @categories.each do |cat|
      if cat.categorizable_id
        @search_one << cat.categorizable_id
      end
    end
    # search by name
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
    @categories_all = ENV["categories"].split(",")
    @categories_all.prepend("")
  end



  def new
    @organization = Organization.new
    @categories = ENV["categories"].split(",")
    @current_category = ENV["categories"].first
  end

  def create
    @organization = Organization.new(organization_params)
    @organization.user_id = current_user.id
    @organization.categories << Category.create(name: params[:organization][:categories])
    if @organization.save
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def edit
    @organization = Organization.find(params[:id])
    @categories = ENV["categories"].split(",")
    if @organization.categories.any?
      @current_category = @organization.categories.last.name
    else
      @current_category = ENV["categories"].first
    end
  end

  def update
    @organization = Organization.find(params[:id])
    @organization.update(organization_params)
    if @organization.categories.any?
      @organization.categories.last.update(name: params[:organization][:categories])
    else
      @organization.categories << Category.create(name: params[:organization][:categories])
      @organization.save
    end
    redirect_to organization_path(@organization)
  end

  def show
    # trying to display search results by categories #
    @organizations = Organization.where(:category_ids => "category".to_i)
    @organization = Organization.find(params[:id])
    @categories = Category.all
    @organizations_relevant = Organization.where.not(user_id: current_user.id)
    if @organization.categories.any?
      suggested_organizations = []
      organization_category = @organization.categories.last.name
      @organizations_relevant.each do |organization|
        if organization.categories.last.name == organization_category
          suggested_organizations << organization
        end
      end
    end
    if suggested_organizations.any?
      @suggested_organizations_shuffled = suggested_organizations.shuffle[1..3]
    end
    events = @organization.events
    @events = events.where('date >= ?', Date.today).order(date: :asc)
  end

  def destroy
    @organization = Organization.find(params[:id])
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
    organization_params = params.require(:organization).permit(:name, :problem, :description, :website, :email, :address, :photo, :logo, :category_ids, :user_is_a_representative, :accepted?)
  end
end
