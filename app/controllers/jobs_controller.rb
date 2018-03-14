class JobsController < ApplicationController
  def new
    authorize @organization = Organization.find(params[:organization_id])
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    @job.organization = Organization.find(params[:organization_id])
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
    authorize @organization = Organization.find(params[:organization_id])
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    
    authorize @job
    @job.update(job_params)
    redirect_to dashboard_path
  end

  def show
    @organization = Organization.find(params[:organization_id])
    @job = Job.find(params[:id])
  end

  def destroy
    @job = Job.find(params[:id])
    authorize @job.destroy
    redirect_to root_path
  end

  private

  def job_params
    params.require(:job).permit(:name, :address, :website, :email, :job_type, :task, :requirement, :active )
  end
end
