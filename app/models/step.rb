class Step < ApplicationRecord
  belongs_to :recipe
   attachment :image

  validates :explanation, presence: true
end
