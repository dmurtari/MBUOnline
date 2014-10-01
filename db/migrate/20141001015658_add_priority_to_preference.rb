class AddPriorityToPreference < ActiveRecord::Migration
  def change
    add_column :preferences, :priority, :integer
  end
end
