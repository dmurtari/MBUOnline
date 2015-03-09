class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :semester
      t.string :year

      t.timestamps
    end
  end
end
