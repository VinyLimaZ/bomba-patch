class ChangeNameTypeFromTeams < ActiveRecord::Migration[7.0]
  def up
    enable_extension('citext')

    change_column :teams, :name, :citext, null: false
    add_index :teams, :name, unique: true, name: :index_teams_name
  end

  def down
    disable_extension('citext')

    change_column :teams, :name, :string, null: false
    remove_index :teams, :name, name: :index_teams_name
  end
end
