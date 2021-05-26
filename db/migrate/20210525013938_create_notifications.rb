class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :post_id
      t.integer :comment_id
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end

    add_index :notifications, :visitor_id
    add_index :notifications, :visited_id
    add_index :notifications, :post_id
    add_index :notifications, :comment_id
    # change_table :notification, bulk: true do |t|
    #   t.index :visitor_id
    #   t.index :visited_id
    #   t.index :post_id
    #   t.index :comment_id
    #   t.index %i[visitor_id visited_id post_id comment_id]
    # end
  end
end
