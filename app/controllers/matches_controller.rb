# frozen_string_literal: true

class MatchesController < ApplicationController

  def index
    @matches = Match.all
  end
end
