require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rails6Chat
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.encoding = "utf-8"
    config.assets.precompile += %w(*.svg *.eot *.woff *.ttf )

    config.generators do |g|
      g.test_framework :rspec, :view_specs => false
    end

    config.to_prepare do
      Devise::Mailer.layout "mailer"
      Devise::RegistrationsController.layout proc{ |controller| user_signed_in? ? "application"   : "auth" }
      Devise::SessionsController.layout "auth"
      Devise::ConfirmationsController.layout "auth"
      Devise::UnlocksController.layout "auth"
      Devise::PasswordsController.layout "auth"
    end

    config.autoload_paths += Dir["#{config.root}/lib"]
    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')

  end
end
