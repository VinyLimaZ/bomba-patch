# frozen_string_literal: true

class ApplicationController < ActionController::API
  attr_accessor :current_user
  # prepend_before_action :authenticate_user!

  def authenticate_user!
  #   payload = JwtAuth.decode(auth_token)
  #   @current_user = User.find(payload['sub'])
  # rescue ActiveRecord::RecordNotFound
  #   render json: { error: 'User not found' }, status: :unauthorized
  # rescue JWT::ExpiredSignature
  #   render json: { error: 'Invalid auth token' }, status: :unauthorized
    @current_user = User.first
  end

  def auth_token
    @auth_token ||= request.headers.fetch('Authorization', '').split(' ').last
  end
end
