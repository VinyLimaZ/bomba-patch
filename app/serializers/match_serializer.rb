# frozen_string_literal: true

class MatchSerializer
  include JSONAPI::Serializer
  attributes :home_team, :away_team
end
