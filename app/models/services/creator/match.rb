module Services
  module Creator
    class Match
      INDEX_GOAL_HOME_TEAM = 1
      INDEX_GOAL_AWAY_TEAM = 3
      INDEX_CURRENT_MATCH_TIME = 6

      class << self
        def create(match_params)
          ::Match.upsert(match_params, unique_by: [:home_team_id, :away_team_id])
        end
      end
    end
  end
end
