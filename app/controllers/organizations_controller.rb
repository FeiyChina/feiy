class OrganizationsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :search]
  before_action :find_organization, only: [:edit, :update, :show, :destroy, :like]

  def index
    @organizations = Organization.where(accepted?: true)
  end

  def search
    @organizations = Organization.where(accepted?: true)

    if params[:name] != ""
      @organizations = @organizations.where("name = ?", params[:name])
    end

    if params[:category] != ""
      @organizations = @organizations.tagged_with(params[:category])
    end
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)
    @organization.user_id = current_user.id
    @organization = update_tag(tag_params[:tags]) if tag_params[:tags]
    if @organization.save
      MIXPANEL.track(@organization.user_id, 'Organization Created', {
        content: "Organization",
        name: @organization.name,
        address: @organization.address,
        website: @organization.website

      })

      redirect_to dashboard_path
    else
      render :new
    end
  end

  def edit
    authorize @organization
  end

  def update
    authorize @organization
    @organization.update(organization_params)
    @organization = update_tag(tag_params[:tags]) if tag_params[:tags]
    @organization.user_id = current_user.id
    if @organization.save
      MIXPANEL.track(@organization.user_id, 'Organization Updated', {
        content: "Organization",
        name: @organization.name,
        address: @organization.address,
        website: @organization.website

      })

      redirect_to organization_path(@organization)
    else
      render :new
    end
  end

  def show
    tag = @organization&.tags&.first&.name
    @organizations = Organization.accepted.tagged_with(tag).where.not(id: params[:id])
    if @organizations.any?
      @suggested_organizations_shuffled = @organizations.shuffle
    else
      @suggested_organizations_shuffled = []
    end
    events = @organization.events
    @events = events.where('date >= ?', Date.today).order(date: :asc)
  end

  def destroy
    authorize @organization
    @organization.destroy
    flash[:notice] = "Your organization has been deleted!"
    redirect_to root_path
  end

  def like
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

  def find_organization
    @organization = Organization.friendly.find(params[:id])
    if params[:id] != @organization.slug && params[:id]&.to_i != @organization.id
      return redirect_to organization_path( @organization), status: :moved_permanently
    end
  end

  def update_tag(tag)
    @organization.tag_list.remove(@organization.tags.map(&:name))
    @organization.tag_list.add(ActsAsTaggableOn::Tag.find_by(name: tag))
    @organization
  end

  def tag_params
    params.require(:organization).permit(:tags)
  end

  def organization_params
    params.require(:organization).permit(:name, :problem, :description, :website,
      :email, :address, :photo, :logo, :user_is_a_representative,
      :slug, :accepted?)
  end
end
