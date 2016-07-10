class AddCategoryToRecords < ActiveRecord::Migration
  def change
    add_column :records, :category, :integer, default: 0
  end
end