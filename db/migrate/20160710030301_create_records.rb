class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :item
      t.string :description
      t.decimal :price
      t.integer :quantity
      t.string :supplier
      t.string :link
      t.string :status

      t.timestamps null: false
    end
  end
end
