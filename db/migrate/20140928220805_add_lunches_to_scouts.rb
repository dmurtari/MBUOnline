class AddLunchesToScouts < ActiveRecord::Migration
  def change
  add_column :scouts, :scout_lunch, :boolean
  add_column :scouts, :additional_lunch, :integer
  end
end
