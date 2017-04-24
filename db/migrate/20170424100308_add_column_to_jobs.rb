class AddColumnToJobs < ActiveRecord::Migration[5.0]
  def change
    add_reference :jobs, :organization, foreign_key: true
  end
end
