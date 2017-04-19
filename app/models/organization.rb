class Organization < ApplicationRecord
  acts_as_votable
  has_attachment :photo
  belongs_to :user
end
