class AddUserRefToRecords < ActiveRecord::Migration
  def change
    add_reference :records, :user, index: true, foreign_key: true
  end
end
