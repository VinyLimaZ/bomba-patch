# frozen_string_literal: true

module Parsers
  module Csv
    class Teams
      RANGE = [0, 2]

      class << self
        def call(rows)
          Team.upsert_all(
            map_rows_attributes(rows),
            returning: %i[name id],
            unique_by: :name
          )
        end

        def map_rows_attributes(rows)
          rows.map { |row| attributes(row) }.flatten.uniq
        end

        def attributes(row)
          RANGE.map { |index| { name: row[index] } }
        end
      end
    end
  end
end
