module Services
  module Csv
    class Parser
      class << self
        private

        def parser(csv)
          ::CSV.parse(csv).each do |row|
            team_ids = ::Creator::Team.create(row)
            ::Creator::Match.create(row, team_ids)
          end
        end
      end
    end
  end
end
