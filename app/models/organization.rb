class Organization < ApplicationRecord
  acts_as_taggable
  scope :accepted, -> { where(accepted?: true) }
  has_attachment :logo, accept: [:jpg, :png, :gif]
  has_attachment :photo, accept: [:jpg, :png, :gif]
  acts_as_commentable
  acts_as_votable
  belongs_to :user
  has_many :events, dependent: :destroy
  has_many :jobs, dependent: :destroy
  validates :user_is_a_representative, presence: true
end
