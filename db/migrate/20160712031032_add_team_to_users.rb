class AddTeamToUsers < ActiveRecord::Migration
  def change
    add_column :users, :team, :integer, default: 0
  end
end
