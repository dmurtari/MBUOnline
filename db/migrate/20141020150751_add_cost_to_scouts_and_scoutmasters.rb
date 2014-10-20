class AddCostToScoutsAndScoutmasters < ActiveRecord::Migration
  def change
    add_column :scouts, :cost, :decimal
    add_column :users, :total_cost, :decimal
  end
end
