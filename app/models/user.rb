class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable,omniauth_providers: [:google_oauth2]
  enum is_gender: { man: 0, woman: 1 }
  has_many :recipes, dependent: :destroy
  has_many :impressions, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :sns_credentials
  attachment :image

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :phone_number, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password_confirmation, confirmation: true, on: :create
  validates :password, presence: true, unless: :id?, on: :create
  validates :introduction, length: { maximum: 50 }

 #Mysqlでtext型はデフォルト登録できないためモデルで処理
  after_save do
    update_column(:nickname,"ニックネーム未登録")
    update_column(:introduction,"自己紹介未登録")
  end

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

  def self.find_omniauth(auth)#SNS認証での新規登録またはsnsログイン
    sns_credential = SnsCredential.where(uid: auth.uid, provider: auth.provider).first
    unless sns_credential.blank?#sns認証済み(ログイン)
      user = User.find(sns_credential.user_id)
    else#sns認証での新規登録
      temp_pass = Devise.friendly_token[0,20]
        user = User.create!(
          last_name: auth.info.last_name,
          first_name: auth.info.first_name,
          image:  auth.info.image,
          phone_number: "未設定",
          is_gender: 1,
          nickname: auth.info.name,
          email: auth.info.email,
          password: temp_pass,
          password_confirmation: temp_pass,
          )
        sns_credential = SnsCredential.create!(
          user_id: user.id,
          provider: auth.provider,
          uid: auth.uid,
           )
    end
    return user
  end

  def self.attach_social(auth, user_id)#sns連携追加時
    sns_credential = SnsCredential.create!(
      user_id: user_id,
      provider: auth.provider,
      uid: auth.uid,
      )
  end

end
