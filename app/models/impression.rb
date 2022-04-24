class Impression < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  has_many :notifications, dependent: :destroy

  attachment :image

  validates :impression, presence: true, length: { maximum: 50 }
  validates :recipe_id, presence: true
  validates :user_id, presence: true

  def create_notification_impression!(current_user, recipe_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      impression_id: id,
      visitor_id: current_user.id,
      recipe_id: recipe_id.id,
      visited_id: visited_id.id,
      action: 'impression'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

end
