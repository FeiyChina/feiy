class Organization < ApplicationRecord
  has_attachments :photos, maximum: 3
  acts_as_commentable
  acts_as_votable
  belongs_to :user
  has_many :categories, as: :categorizable
end
