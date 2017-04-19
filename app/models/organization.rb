class Organization < ApplicationRecord
  acts_as_votable
  has_attachments :photos, maximum: 3
  belongs_to :user
end
