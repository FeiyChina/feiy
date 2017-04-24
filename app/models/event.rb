class Event < ApplicationRecord
  belongs_to :organization
  acts_as_votable
end
