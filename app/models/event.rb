class Event < ApplicationRecord

  belongs_to :organization
  acts_as_votable

  has_attachment :flyer, accept: [:jpg, :png, :gif]

  scope :accepted, -> { joins(:organization).where("organizations.accepted?" => true) }
  scope :future, -> (date) { where("date >= ?", Date.today).order(date: :asc) }

  geocoded_by :venue
  after_validation(:geocode, { if: :venue_changed? })

  def normalized_register_link
    register_link && PostRank::URI.normalize(register_link).to_s
  end
end
