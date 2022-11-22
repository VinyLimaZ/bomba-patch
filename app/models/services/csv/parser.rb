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
            home_team_goal: row[Match::INDEX_GOAL_HOME_TEAM],
            away_team_goal: row[Match::INDEX_GOAL_AWAY_TEAM]
          }
        end
      end
    end
  end
end
