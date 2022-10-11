# frozen_string_literal: true

module ApiHelpers
  def authenticate!(user)
    token = JwtAuth.encode(sub: user.id)
    { 'Authorization': "Bearer #{token}" }
  end
end
