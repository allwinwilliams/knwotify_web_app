require_relative 'boot'

require 'rails/all'

require 'neo4j/railtie'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module KnowtifyWebApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.

    config.load_defaults 5.1

    config.api_only = false
    
    config.neo4j.session.type = :bolt
    config.neo4j.session.path = 'bolt://neo4j:password@localhost:7687'



    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

  end
end
