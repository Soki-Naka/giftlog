class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :comment_likes, dependent: :destroy
  has_many :notifications, dependent: :destroy
  validates :content, presence: true, length: { maximum: 400 }

  def create_notification_comment_like!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(['visitor_id = ? and visited_id = ? and comment_id = ? and action = ? ', current_user.id, user_id, id, 'comment_like'])
    # いいねされていない場合のみ、通知レコードを作成
    return if temp.present?

    notification = current_user.active_notifications.new(
      comment_id: id,
      visited_id: user_id,
      action: 'comment_like'
    )
    notification.save if notification.valid?
  end
end
