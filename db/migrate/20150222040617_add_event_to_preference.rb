class AddEventToPreference < ActiveRecord::Migration
  def change
    add_reference :preferences, :event, index: true
  end
end
