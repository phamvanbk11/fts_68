class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :chatwordId
      t.boolean :admin

      t.timestamps null: false
    end
    add_index :users, :email, unique: true
  end
end
