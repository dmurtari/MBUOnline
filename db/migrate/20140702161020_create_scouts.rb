class CreateScouts < ActiveRecord::Migration
  def change
    create_table :scouts do |t|
      t.string :firstname
      t.string :lastname
      t.integer :user_id

      t.timestamps
    end

    add_index :scouts, [:user_id]

  end
end
