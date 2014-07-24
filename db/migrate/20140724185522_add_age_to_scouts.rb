class AddAgeToScouts < ActiveRecord::Migration
  def change
    add_column :scouts, :age, :integer
  end
end
