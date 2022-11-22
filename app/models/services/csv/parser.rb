module Services
  module CSV
    class Parser
      class << self
        private

        def parser(csv)
          ::CSV.parse(csv).each do |row|
            team_ids = Team::Creator.create(team_columns(row))
            Match::Creator.create(match_columns(row), team_ids)
          end
        end

        def team_columns(row)
          Team::RANGE.map do |index|
            { name: row[index] }
          end
        end

        def match_columns(row, team_ids)
          {
            home_team_id: team_ids.first,
            away_team_id: team_ids.last,
            goals_home_team: row[Match::INDEX_GOAL_HOME_TEAM],
            goals_away_team: row[Match::INDEX_GOAL_AWAY_TEAM],
          }
        end
      end
    end
  end
end
