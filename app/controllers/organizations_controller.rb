class OrganizationsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :search]

  def index
    @organizations = Organization.where(accepted?: true)
  end

  def search
    @organizations = Organization.where(accepted?: true)

    if params[:name] != ""
      @organizations = @organizations.where("name = ?", params[:name])
    end

    if params[:category] != ""
      @organizations = @organizations.where("category = ?", params[:category])
    end
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)
    @organization.user_id = current_user.id
    if @organization.save
      MIXPANEL.track(@organization.user_id, 'Created', {
        content: "Organization",
        name: @organization.name
      })

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
    @organizations = Organization.where(category: @organization.category).where.not(id: params[:id])
    if @organizations.any?
      @suggested_organizations_shuffled = @organizations.shuffle
    else
      @suggested_organizations_shuffled = []
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
    redirect_to organization_path(@organization)
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

  def organization_params
    organization_params = params.require(:organization).permit(:name, :problem, :description, :website, :email, :address, :photo, :logo, :category, :user_is_a_representative, :accepted?)
  end
end
