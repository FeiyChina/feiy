class Organization < ApplicationRecord
  has_attachment :logo
  has_attachment :photo

  acts_as_commentable
  acts_as_votable

  belongs_to :user
end
