# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def create
        @user = User.create(user_params)
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
