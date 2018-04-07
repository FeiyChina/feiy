class Job < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :history

  validates :job_type, inclusion: { in: %w(Volunteer Internship Part-time Full-time) }
  belongs_to :organization

  scope :accepted, -> { joins(:organization).where("organizations.accepted?" => true) }
  scope :activated, -> { where("jobs.active" => true).order(created_at: :desc) }

  def should_generate_new_friendly_id?
    name_changed?
  end
end
