# frozen_string_literal: true

module Parsers
  module Csv
    class Matches
      INDEXES = {
        home_team: 0,
        away_team: 2,
        goal_home_team: 1,
        goal_away_team: 3,
        started_at: 4,
        current_match_time: 6
      }.freeze

      UNIQUE_INDEX = :index_matches_unique

      class << self
        def call(rows, team_ids = [])
          Match.upsert_all(
            map_rows_attributes(rows, team_ids.to_a),
            unique_by: UNIQUE_INDEX
          )
        end

        def map_rows_attributes(rows, team_ids)
          rows.map { |row| attributes(row, team_ids) }.flatten
        end

        def find_team_by_name(row, index, team_ids)
          result = team_ids.find { |t| t['name'] == row[index] }
          result&.dig('id')
        end

        def attributes(row, team_ids)
          {
            home_team_id: find_team_by_name(row, INDEXES[:home_team], team_ids),
            away_team_id: find_team_by_name(row, INDEXES[:away_team], team_ids),
            goals_home_team: row[INDEXES[:goals_home_team]],
            goals_away_team: row[INDEXES[:goals_away_team]],
            started_at: row[INDEXES[:started_at]],
            current_match_time: row[INDEXES[:current_match_time]]
          }
        end
      end

    end
  end
end
