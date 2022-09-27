require_relative "boot"

require 'rails'

%w[active_model/railtie active_job/railtie active_record/railtie
active_storage/engine action_controller/railtie action_view/railtie
action_cable/engine].each do |railtie|
  require railtie
end

Bundler.require(*Rails.groups)

module BombaPatch
  class Application < Rails::Application
    config.load_defaults 7.0

    config.time_zone = 'Brasilia'
    # config.eager_load_paths << Rails.root.join("extras")
    config.generators.system_tests = nil
  end
end
