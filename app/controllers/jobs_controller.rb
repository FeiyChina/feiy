class JobsController < ApplicationController
  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
  end

  def destroy
  end

end
