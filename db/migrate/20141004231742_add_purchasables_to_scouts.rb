class AddPurchasablesToScouts < ActiveRecord::Migration
  def change
   add_column :scouts, :patch, :boolean
   add_column :scouts, :shirt, :boolean
   add_column :scouts, :shirt_size, :string
  end
end
