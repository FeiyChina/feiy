class Event < ApplicationRecord
  belongs_to :organization
  acts_as_votable

  geocoded_by :venue
  after_validation(:geocode, { if: :venue_changed? })
end
