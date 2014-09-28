class AddTroopToScouts < ActiveRecord::Migration
  def change
    add_column :scouts, :troop, :integer
  end
end
