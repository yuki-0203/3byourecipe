class Step < ApplicationRecord
  belongs_to :recipe
   attachment :image
end
