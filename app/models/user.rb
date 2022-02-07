class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum is_gender: { man: 0, woman: 1 }
  has_many :recipes, dependent: :destroy
  has_many :impressions, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :image
end
