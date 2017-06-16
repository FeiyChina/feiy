class Job < ApplicationRecord

  validates :job_type, inclusion: { in: %w(Volunteer Internship Part-time Full-time) }
  belongs_to :organization

  scope :accepted, -> { joins(:organization).where("organization.accepted?" => true) }
  scope :activated, -> { where("job.active" => true).order(created_at: :desc) }
end
