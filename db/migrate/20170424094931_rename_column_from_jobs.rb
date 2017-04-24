class RenameColumnFromJobs < ActiveRecord::Migration[5.0]
  def change
    rename_column :jobs, :type, :job_type
  end
end
