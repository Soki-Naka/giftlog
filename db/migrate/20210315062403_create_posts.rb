class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :who
      t.string :gender
      t.string :age
      t.string :job
      t.string :situation
      t.string :item
      t.string :price
      t.string :when
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :posts, %i[user_id created_at]
  end
end
