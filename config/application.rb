require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ChatSystem
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Setup rails to STDOUT and also set up a custom formatter to 
    # include both the subdomain and uuid in each log entry.
    # logger           = ActiveSupport::Logger.new(STDOUT)
    # logger.formatter = config.log_formatter
    # config.log_tags  = [:subdomain, :uuid]
    # config.logger    = ActiveSupport::TaggedLogging.new(logger)

    # # To read Sidekiq files
    config.autoload_paths += %W(#{config.root}/app/workers)

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
