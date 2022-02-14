class Recipe < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :materials, dependent: :destroy
  accepts_nested_attributes_for :materials, allow_destroy: true
  has_many :steps, dependent: :destroy
  accepts_nested_attributes_for :steps, allow_destroy: true
  has_many :recipe_tags, dependent: :destroy
  has_many :impression, dependent: :destroy

  validates :user_id, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :serving, presence: true
  validates :image_id, presence: true



  attachment :image
  acts_as_taggable #タグ



end
