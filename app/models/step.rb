class Step < ApplicationRecord
  belongs_to :recipe
  counter_culture :recipe
   attachment :image

  validates :explanation, presence: true
end
