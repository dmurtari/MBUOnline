class AddCompletionToRecords < ActiveRecord::Migration
  def change
    add_column :records, :completion, :string
  end
end
