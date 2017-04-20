class Category < ApplicationRecord
  belongs_to :categorizable, polymorphic: true
end
