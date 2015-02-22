class AddEventToRecord < ActiveRecord::Migration
  def change
    add_reference :records, :event, index: true
  end
end
