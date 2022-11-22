class AddFieldsToMatches < ActiveRecord::Migration[7.0]
  def change
    add_column :matches, :goals_home_team, :integer, default: 0
    add_column :matches, :goals_away_team, :integer, default: 0
    add_column :matches, :current_match_time, :timestamp
  end
end
