class Notification < ApplicationRecord
　#新しい通知から取得
  default_scope -> { order(created_at: :desc) }
  belongs_to :impression, optional: true
  belongs_to :recipe, optional: true

  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
end
