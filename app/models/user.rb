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
  validates :phone_number, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password_confirmation, confirmation: true, on: :create
  validates :password, presence: true, unless: :id?, on: :create
  validates :introduction, length: { maximum: 50 }

  def self.guest
    find_or_create_by!(email: 'aaa@aaa.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.password_confirmation = user.password
      user.last_name = 'ゲスト姓'
      user.first_name = 'ゲスト名'
      user.phone_number = '09000000000'
      user.is_gender = 1
      user.nickname = 'ゲスト'
      user.introduction = 'ゲストです!!'
    end
  end

end
