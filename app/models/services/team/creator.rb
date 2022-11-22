module Services
  module Team
    RANGE = [0,2]

    class Creator
      class << self
        def create(team_params)
          ::Team.upsert(team_params, returning: [:id], unique_by: :name)
        end
      end
    end
  end
end
