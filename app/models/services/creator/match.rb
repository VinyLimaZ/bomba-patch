module Services
  module Creator
    class Match
      INDEX_GOAL_HOME_TEAM = 1
      INDEX_GOAL_AWAY_TEAM = 3
      INDEX_CURRENT_MATCH_TIME = 6

      class << self
        def create(row, team_ids = [])
          ::Match.upsert(match_attributes(row, team_ids), unique_by: [:home_team_id, :away_team_id])
        end

        def match_attributes(row, team_ids)
          {
            home_team_id: team_ids.first,
            away_team_id: team_ids.last,
            goals_home_team: row[INDEX_GOAL_HOME_TEAM],
            goals_away_team: row[INDEX_GOAL_AWAY_TEAM],
            current_match_time: row[INDEX_CURRENT_MATCH_TIME]
          }
        end
      end
    end
  end
end
