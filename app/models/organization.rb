class Organization < ApplicationRecord
  has_attachments :photos, maximum: 3
  has_attachment :logo
  has_attachment :photo
  acts_as_commentable
  acts_as_votable
  belongs_to :user
  has_many :categories, as: :categorizable
end
