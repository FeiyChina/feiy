class Organization < ApplicationRecord
  acts_as_voteable
  belongs_to :user
end
