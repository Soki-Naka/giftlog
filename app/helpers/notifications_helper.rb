module NotificationsHelper
  def notification_form(notification)
    visitor = notification.visitor
    # @visited = notification.visited
    @comment = nil
    # your_post = link_to 'あなたの投稿', post_path(notification), style: 'font-weight: bold;'
    visitor_comment = notification.comment_id
    # notification.actionがfollowかpostlikeかcomment_likeかcommentか
    case notification.action
    when 'follow'
      tag.a(notification.visitor.name, href: user_path(visitor), style: 'font-weight: bold;') + 'さんがあなたをフォローしました'
    when 'post_like'
      tag.a(notification.visitor.name, href: user_path(visitor), style: 'font-weight: bold;') + 'さんが' + tag.a('あなたの投稿', href: post_path(notification.post_id), style: 'font-weight: bold;') + 'にいいねしました'
    when 'comment_like'
      tag.a(notification.visitor.name, href: user_path(visitor), style: 'font-weight: bold;') + 'さんが' + tag.a("あなたのコメント(#{notification.comment.content})", href: post_path(notification.comment.post_id), style: 'font-weight: bold;') + 'にいいねしました'
    when 'comment'
      @comment = Comment.find_by(id: visitor_comment)&.content
      # @post = Post.find_by(id: @visitor_post)
      # if notification.post.user_id == @visited.id
      tag.a(visitor.name, href: user_path(visitor), style: 'font-weight: bold;') + 'さんが' + tag.a('あなたの投稿', href: post_path(notification.post_id), style: 'font-weight: bold;') + 'にコメントしました'
      # end
    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
