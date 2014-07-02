class AddDetailsToScouts < ActiveRecord::Migration
  def change
    add_column :scouts, :dob, :date
    add_column :scouts, :emergency_name, :string
    add_column :scouts, :emergency_relation, :string
    add_column :scouts, :emergency_phone, :string
    add_column :scouts, :notes, :string
  end
end
