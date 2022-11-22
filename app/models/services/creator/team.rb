module Services
  module Creator
    class Team
      RANGE = [0, 2]

      class << self
        def create(row)
          ::Team.upsert(team_attributes(row), returning: [:id], unique_by: :name)
        end

        def team_attributes(row)
          RANGE.map { |index| { name: row[index] } }
        end
      end
    end
  end
end
