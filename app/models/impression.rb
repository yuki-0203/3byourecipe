class Impression < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  attachment :image
end
