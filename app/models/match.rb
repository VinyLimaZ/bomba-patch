class Match < ApplicationRecord
  belongs_to :home_team, foreign_key: :home_team_id, class_name: 'Team'
  belongs_to :away_team, foreign_key: :away_team_id, class_name: 'Team'
end
