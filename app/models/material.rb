class Material < ApplicationRecord
  belongs_to :recipe

  validates :recipe_id, presence: true
  validates :name, presence: true
  validates :quantity, presence: true

end
