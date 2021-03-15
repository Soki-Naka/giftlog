class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :gender
      t.integer :age
      t.string :job
      t.string :prefecture
      t.text :introduction

      t.timestamps
    end
  end
end
