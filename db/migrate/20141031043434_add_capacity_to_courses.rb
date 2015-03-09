class AddCapacityToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :capacity, :integer
  end
end
