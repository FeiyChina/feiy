class JobsController < ApplicationController


  def new
    @organization = Organization.find(params[:organization_id])
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    @job.organization = Organization.find(params[:organization_id])
    @job.save
      redirect_to dashboard_path
  end

  def edit
    @organization = Organization.find(params[:organization_id])
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    @job.update(job_params)
    redirect_to dashboard_path
  end

  def show
    @job = Job.find(params[:id])
  end


  def destroy
    @job = job.find(params[:id])
    @job.destroy
    redirect_to root_path
  end

  private

  def job_params
    params.require(:job).permit(:name, :address, :website, :email, :job_type, :task, :requirement, :active )
  end

end
