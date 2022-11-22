# frozen_string_literal: true

require 'csv'

module Parsers
  module Csv
    class Parser
      class << self
        def call(csv_path)
          csv_rows = CSV.foreach(csv_path, headers: true)
          team_ids = Teams.call(csv_rows)
          Matches.call(csv_rows, team_ids)
        end
      end
    end
  end
end
