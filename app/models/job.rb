class Job < ApplicationRecord


  validates :job_type, inclusion: { in: %w(Volunteer Internship Part-time Full-time) }
  belongs_to :organization
end
