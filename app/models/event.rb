class Event < ApplicationRecord
  belongs_to :organization
  acts_as_votable

  geocoded_by :full_street_address
  after_validation :geocode
end
