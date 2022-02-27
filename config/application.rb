require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DatsuryokuRecipe
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.yml').to_s]

    # deviseフラッシュメッセージ日本語化
    config.i18n.default_locale = :ja
    # enumを日本語化
    config.i18n.load_path += Dir[Rails.root.join('config/locales/*.yml').to_s]
    config.time_zone = 'Asia/Tokyo'
    # デフォルトのロケールを日本（ja）に設定（参考記事：https://qiita.com/jnchito/items/831654253fb8a958ec25）
    config.i18n.default_locale = :ja

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
  # Rspec
  # config.generators do |g|
  # g.test_framework :rspec
  # end
end
