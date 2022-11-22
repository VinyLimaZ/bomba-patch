class AddIndexesAndReferencesForMatches < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :matches, :teams, column: :home_team_id
    add_foreign_key :matches, :teams, column: :away_team_id

    add_index :matches, %i[home_team_id away_team_id], unique: true, name: :index_matches_unique
  end
end
