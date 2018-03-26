class JobsController < ApplicationController
  before_action :find_job, only: [:edit, :update, :show, :destroy]
  before_action :find_organization, only: [:new, :create, :edit, :show]

  def new
    authorize @organization
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    @job.organization = @organization
    if @job.save
      MIXPANEL.track(@job.organization.user_id, 'Created', {
        content: "Job",
        name: @job.name,
        address: @job.address,
        job_type: @job.job_type,
        organization: @job.organization_id,
        active: @job.active
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
    authorize @job
    @job.update(job_params)
    redirect_to dashboard_path
  end

  def show; end

  def destroy
    authorize @job.destroy
    redirect_to root_path
  end

  private

  def find_job
    @job = Job.friendly.find(params[:id])
    if params[:id] != @job.slug && params[:id]&.to_i != @job.id
      return redirect_to job_path(@job), status: :moved_permanently
    end
  end

  def find_organization
    @organization = Organization.friendly.find(params[:organization_id])
  end

  def job_params
    params.require(:job).permit(:name, :address, :website, :email, :job_type, :task, :requirement, :active)
  end
end
