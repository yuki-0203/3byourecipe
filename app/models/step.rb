class Step < ApplicationRecord
  belongs_to :recipe
   attachment :image

  validates :recipe_id, presence: true
  validates :explanation, presence: true
end
