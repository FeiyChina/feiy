class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.string  :name
      t.string  :address
      t.string  :website
      t.string  :email
      t.string  :job_type, inclusion: { in: %w(volunteer internship part-time full-time)}
      t.string  :task
      t.string  :requirement
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
