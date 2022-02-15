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

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true
  validates :password_confirmation, presence: true, on: :create
  validates :password, presence: true, unless: :id?, on: :create

end
