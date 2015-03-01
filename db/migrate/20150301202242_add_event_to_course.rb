class AddEventToCourse < ActiveRecord::Migration
  def change
    add_reference :courses, :event, index: true
  end
end
