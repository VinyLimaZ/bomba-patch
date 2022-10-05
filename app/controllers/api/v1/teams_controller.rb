# frozen_string_literal: true

module Api
  module V1
    class TeamsController < ApplicationController
      def show
        render json: TeamSerializer.new(Team.find(params[:id]))
      end

      def index
        render json: TeamSerializer.new(Team.all)
      end

      def create
        team = Team.new(team_params)
        if team.save
          render json: TeamSerializer.new(team)
        else
          render json: { errors: team.errors }, status: :unprocessable_entity
        end
      end

      def update
        team = Team.find(params[:id])
        if team.update(team_params)
          render json: TeamSerializer.new(team)
        else
          render json: { errors: team.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        team = Team.find(params[:id])
        team.destroy
      end

      private

      def team_params
        params.require(:team).permit(
          :name, :description, :photo
        )
      end
    end
  end
end
