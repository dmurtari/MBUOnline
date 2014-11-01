class AddEnrolleesToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :first_period, :integer
    add_column :courses, :second_period, :integer
    add_column :courses, :third_period, :integer
  end
end
