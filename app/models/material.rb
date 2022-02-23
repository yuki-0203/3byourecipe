class Material < ApplicationRecord
  belongs_to :recipe

  validates :name, presence: true, length: { in: 1..20 }
  validates :quantity, presence: true, length: { in: 1..10 }
end
