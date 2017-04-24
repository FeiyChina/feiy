class JobsController < ApplicationController
  def new
    @organization = Organization.find(params[:organization_id])
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    @job.organization = Organization.find(params[:organization_id])
    @job.save
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    @job.update(job_params)
  end

  def destroy
  end

  private

  def job_params
    params.require(:job).permit(:name, :address, :website, :email, :type, :task, :requirement, :active )
  end

end
