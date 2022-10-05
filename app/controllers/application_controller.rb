# frozen_string_literal: true

class ApplicationController < ActionController::API
  attr_accessor :current_user
  prepend_before_action :authenticate_user!

  def authenticate_user!
    payload = JwtAuth.decode(auth_token)

    @current_user = User.find(payload['sub'])
  end

  def auth_token
    @auth_token ||= request.headers.fetch('Authorization', '').split(' ').last
  end
end
