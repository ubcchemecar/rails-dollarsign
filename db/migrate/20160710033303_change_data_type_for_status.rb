class ChangeDataTypeForStatus < ActiveRecord::Migration
  def change
    change_column(:records, :status, :integer)
  end
end
