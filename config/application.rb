require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GameCompendium
  class Application < Rails::Application
	  config.app_generators do |g|
		  g.test_framework :test_unit, fixture_replacement: :fabrication
		  g.fixture_replacement :fabrication, dir: "test/fabricators"
	  end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
