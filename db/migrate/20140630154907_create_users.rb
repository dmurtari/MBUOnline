class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.integer :troop
      t.string :district
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
