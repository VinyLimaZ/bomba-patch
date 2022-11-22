# frozen_string_literal: true

class MatchesController < ApplicationController

  def index
    @matches = Match.includes(:home_team, :away_team)
  end

  def show
    @match = Match.find(params[:id])
  end
end
