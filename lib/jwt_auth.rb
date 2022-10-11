# frozen_string_literal: true

class JwtAuth
  class << self
    EXPIRATION_KIND = ENV.fetch('JWT_EXPIRATION_KIND', 'days')

    def encode(payload, expiration =  30)
      raise TypeError unless payload.is_a? Hash

      payload[:exp] = expiration.send(EXPIRATION_KIND).from_now.to_i
      JWT.encode(payload, jwt_secret)
    end

    def decode(token)
      JWT.decode(token, jwt_secret).first
    end

    private

    def jwt_secret
      BombaPatch::Config.api_secret
    end
  end
end
