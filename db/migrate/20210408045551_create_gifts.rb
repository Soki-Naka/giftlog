class CreateGifts < ActiveRecord::Migration[6.1]
  def change
    create_table :gifts do |t|
      t.string :item
      t.string :situation
      t.string :price
      t.string :when
      t.text :description
      t.references :favorite_person, null: false, foreign_key: true

      t.timestamps
    end
  end
end
