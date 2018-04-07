class Organization < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :history

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

  def should_generate_new_friendly_id?
    name_changed?
  end

  def slug_candidates
    [
      :name,
      [:name, :created_at],
      [:name, :description, :created_at]
    ]
  end
end
