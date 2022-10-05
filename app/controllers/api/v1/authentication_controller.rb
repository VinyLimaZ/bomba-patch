# frozen_string_literal: true

module Api
  module V1
    class AuthenticationController < ApplicationController
      def create
        @user = User.find_by!(email: user_params[:email])
        if @user.authenticate(user_params[:password])
          render json: {
            token: JwtAuth.encode(sub: @user.id)
          }
        else
          render json: { error: 'Password is not right' }, status: :unauthorized
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'User doesnt exists' }, status: :unauthorized
      end

      def user_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end
