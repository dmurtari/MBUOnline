class CreateRecordsAssociation < ActiveRecord::Migration
  def change 
    create_table :records do |t|
      t.belongs_to :scout
      t.belongs_to :course

      t.timestamps
    end
  end
end
