# frozen_string_literal: true

module Api
  module V1
    class MatchesController < ApplicationController
      def show
        render json: MatchSerializer.new(Match.find(params[:id]))
      end

      def index
        render json: MatchSerializer.new(Match.all)
      end

      def create
        match = Match.new(match_params)
        if match.save
          render json: MatchSerializer.new(match)
        else
          render json: { errors: match.errors }, status: :unprocessable_entity
        end
      end

      def update
        match = Match.find(params[:id])
        if match.update(match_params)
          render json: MatchSerializer.new(match)
        else
          render json: { errors: match.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        match = Match.find(params[:id])
        match.destroy
      end

      private

      def match_params
        params.require(:match).permit(
          :home_team_id, :away_team_id
        )
      end
    end
  end
end
