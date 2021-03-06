class Post < ApplicationRecord
  belongs_to :user
  has_many :post_likes, dependent: :destroy
  has_many :liked_users, through: :post_likes, source: :user
  default_scope -> { order(created_at: :desc) }
  has_many :comments, dependent: :destroy
  has_many :commented_users, through: :comments, source: :user
  has_many :notifications, dependent: :destroy
  validates :user_id, presence: true
  validates :who, presence: true, length: { maximum: 50 }
  validates :gender, presence: true
  validates :age, presence: true
  validates :job, length: { maximum: 50 }
  validates :situation, presence: true
  validates :item, presence: true, length: { maximum: 100 }
  mount_uploader :image, ImageUploader
  validates :price, presence: true
  validates :when, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 400 }

  scope :get_by_gender, lambda { |gender|
    where(gender: gender)
  }
  scope :get_by_age, lambda { |age|
    where(age: age)
  }
  scope :get_by_situation, lambda { |situation|
    where(situation: situation)
  }
  scope :get_by_price, lambda { |price|
    where(price: price)
  }

  def create_notification_post_like!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(['visitor_id = ? and visited_id = ? and post_id = ? and action = ? ', current_user.id, user_id, id, 'post_like'])
    # いいねされていない場合のみ、通知レコードを作成
    return if temp.present?

    notification = current_user.active_notifications.new(
      post_id: id,
      visited_id: user_id,
      action: 'post_like'
    )
    # 自分の投稿に対するいいねの場合は、通知済みとする
    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
  end

  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
  end
end
