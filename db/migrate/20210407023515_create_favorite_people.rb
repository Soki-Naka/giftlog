class CreateFavoritePeople < ActiveRecord::Migration[6.1]
  def change
    create_table :favorite_people do |t|
      t.string :name
      t.string :image
      t.date :birthday
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
