# frozen_string_literal: true

module BombaPatch
  Config = SuperConfig.new(raise_exception: false) do
    credential :api_secret
    optional :app_host, string, ENV.fetch('HOST', '127.0.0.1:3000')
  end
end
