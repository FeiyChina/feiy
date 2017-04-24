class Job < ApplicationRecord


  validates :job_type, inclusion: { in: %w(volunteer internship part-time full-time) }
  belongs_to :organization
end
