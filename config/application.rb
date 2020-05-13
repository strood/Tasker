require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Tasker
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Below sets up auto-generatos to make spec files for certian components
    # Models auto get created
    config.generators do |g|
      g.test_framework :rspec,
      :fixtures => false,
      :view_specs => false,
      :helper_specs => false,
      :routiung_specs => false,
      :controller_specs => true,
      :request_specs => false
    end
  end
end