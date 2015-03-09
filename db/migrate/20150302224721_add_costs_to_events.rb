class AddCostsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :event_price, :decimal
    add_column :events, :lunch_price, :decimal
    add_column :events, :tshirt_price, :decimal
    add_column :events, :patch_price, :decimal
  end
end
