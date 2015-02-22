class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.belongs_to :preference, index: true
      t.belongs_to :record, index: true
      t.string :semester
      t.string :year

      t.timestamps
    end
  end
end
