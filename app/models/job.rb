class Job < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :history

  validates :job_type, inclusion: { in: %w(Volunteer Internship Part-time Full-time Associate) }
  # validates :job_address, inclusion: { in: %w(Shanghai China) }
  belongs_to :organization

  filterrific(
    available_filters: [
      :with_job_type
    ]
  )

  scope :with_job_type, lambda { |job_types|
    where(job_type: [*job_types])
  }

  # scope :with_job_type, lambda { |job_addresses|
  #   where(job_address: [*job_addresses])
  # }

  scope :accepted, -> { joins(:organization).where("organizations.accepted?" => true) }
  scope :activated, -> { where("jobs.active" => true).order(created_at: :desc) }

  def should_generate_new_friendly_id?
    name_changed?
  end
end
