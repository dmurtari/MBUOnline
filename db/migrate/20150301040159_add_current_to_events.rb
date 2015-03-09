class AddCurrentToEvents < ActiveRecord::Migration
  def change
    add_column :events, :current, :boolean, default: false
  end
end
