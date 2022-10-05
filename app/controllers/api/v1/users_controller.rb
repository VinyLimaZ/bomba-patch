# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def show
        user = User.find(params[:id])
        render json: UserSerializer.new(user)
      end

      def create
        user = User.new(user_params)
        if user.save
          render json: UserSerializer.new(user)
        else
          render json: { errors: user.errors }, status: :unprocessable_entity
        end
      end

      def update
        user = User.find(params[:id])
        if user.update(user_params)
          render json: UserSerializer.new(user)
        else
          render json: { errors: user.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        user = User.find(params[:id])
        user.destroy
      end

      private

      def user_params
        params.require(:user).permit(
          :name, :email, :password
        )
      end
    end
  end
end
