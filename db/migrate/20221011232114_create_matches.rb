class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.integer :home_team_id
      t.integer :away_team_id
      t.datetime :started_at
      t.datetime :ended_at
      t.timestamps
    end
  end
end
