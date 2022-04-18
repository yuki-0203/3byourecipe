class NotificationsController < ApplicationController
  def index
   　#通知データを取得
    #@notifications = current_user.passive_notifications
    @notifications = Notification.where(visited_id: 3)
	#通知一覧に遷移したら、既読済みにする
    #@notifications.where(checked: false).each do |notification|
     # notification.update_attributes(checked: true)
     #end
  end

end
