class CreatePostLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :post_likes do |t|
      t.integer :post_id
      t.integer :user_id

      t.timestamps
    end
  end
  add_index :post_likes, %i[user_id post_id]
end
