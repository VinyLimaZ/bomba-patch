module Services
  module Creator
    class Team
      RANGE = [0,2]

      class << self
        def create(team_params)
          ::Team.upsert(team_params, returning: [:id], unique_by: :name)
        end
      end
    end
  end
end
