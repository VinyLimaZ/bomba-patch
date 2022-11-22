# frozen_string_literal: true

class Match < ApplicationRecord
  belongs_to :home_team, foreign_key: :home_team_id, class_name: 'Team'
  belongs_to :away_team, foreign_key: :away_team_id, class_name: 'Team'

  after_commit :broadcast_match

  private

  def broadcast_match
    ActionCable.server.broadcast("match_channel_#{id}", as_json)
  end
end
