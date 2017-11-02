class Article < ApplicationRecord
  scope :accepted, -> { where(accepted?: true) }
  has_attachment :photo
  acts_as_commentable
  acts_as_votable
  belongs_to :user
end
