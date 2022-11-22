module Services
  module CSV
    class Parser
      class << self
        private

        def parser(csv)
          ::CSV.parse(csv).each do |row|
            team_ids = ::Creator::Team.create(team_columns(row))
            ::Creator::Match.create(match_columns(row, team_ids))
          end
        end

        def team_columns(row)
          ::Creator::Team::RANGE.map do |index|
            { name: row[index] }
          end
        end

        def match_columns(row, team_ids)
          {
            home_team_id: team_ids.first,
            away_team_id: team_ids.last,
            goals_home_team: row[::Creator::Match::INDEX_GOAL_HOME_TEAM],
            goals_away_team: row[::Creator::Match::INDEX_GOAL_AWAY_TEAM],
            current_match_time: row[::Creator::Match::INDEX_CURRENT_MATCH_TIME]
          }
        end
      end
    end
  end
end
