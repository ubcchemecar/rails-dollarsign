class AddPartNumberToRecords < ActiveRecord::Migration
  def change
    add_column :records, :part_number, :string, default: 'nil'
  end
end
