class Organization < ApplicationRecord
  acts_as_votable
  has_attachments :photo
  belongs_to :user
end
