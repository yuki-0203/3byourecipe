class Recipe < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :materials, inverse_of: :recipe, dependent: :destroy
  accepts_nested_attributes_for :materials, allow_destroy: true
  has_many :steps, inverse_of: :recipe, dependent: :destroy
  accepts_nested_attributes_for :steps, allow_destroy: true
  has_many :impression, dependent: :destroy

  validates :name, presence: true, length: { in: 1..40 }
  validates :introduction, presence: true, length: { in: 1..80 }
  validates :serving, presence: true, numericality: { less_than_or_equal_to: 5 }
  validates :image, presence: true

  attachment :image
  acts_as_taggable # タグ
end
