class AddPeriodToRecords < ActiveRecord::Migration
  def change
    add_column :records, :period, :integer
  end
end
