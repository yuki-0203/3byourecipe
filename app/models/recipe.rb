class Recipe < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :materials, inverse_of: :recipe, dependent: :destroy
  accepts_nested_attributes_for :materials, allow_destroy: true
  has_many :steps, inverse_of: :recipe, dependent: :destroy
  accepts_nested_attributes_for :steps, allow_destroy: true
  has_many :impression, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :name, presence: true, length: { in: 1..40 }
  validates :introduction, presence: true, length: { in: 1..80 }
  validates :serving, presence: true, numericality: { less_than_or_equal_to: 5 }
  validates :image, presence: true

  attachment :image
  acts_as_taggable # タグ
  
  def create_notification_favorite!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and recipe_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        recipe_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
       # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
  
end
