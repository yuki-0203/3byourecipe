module NotificationsHelper
    
   def notification_form(notification)
      @visiter = notification.visiter
      @impression = nil
      your_item = link_to 'あなたのレシピ', recipe_path(notification), style:"font-weight: bold;"
      @visiter_comment = notification.impression_id
      #notification.actionがfollowかlikeかcommentか
      case notification.action
        when "favorite" then
          tag.a(notification.visiter.nickname, href:users_user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたのレシピ', href:recipe_path(notification.recipe_id), style:"font-weight: bold;")+"をお気に入り登録しました"
        when "impression" then
            @comment = Comment.find_by(id: @visiter_comment)&.content
            tag.a(@visiter.nickname, href:users_user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:recipe_path(notification.recipe_id), style:"font-weight: bold;")+"にコメントしました"
      end
　  end
end
