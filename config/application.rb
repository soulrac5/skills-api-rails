require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
require 'carrierwave/orm/activerecord'

module SkillApi
  class Application < Rails::Application
    #mailer
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
     address:              'smtp.office365.com',
     port:                 587,
     domain:               'example.com',
     user_name:            ENV["OFFICE365_USERNAME"],
     password:             ENV["OFFICE365_PASSWORD"],
     authentication: :login,
     enable_starttls_auto: true
    }


    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options, :put]
      end
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
