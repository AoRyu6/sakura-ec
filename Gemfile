source 'https://rubygems.org'

gem 'bootsnap', require: false
gem 'cssbundling-rails'
gem 'devise', git: 'https://github.com/heartcombo/devise', branch: 'main' # NOTE: deviseがまだRails8に対応していないため。Rails8対応版がリリースされたら指定をなくす
gem 'devise-i18n'
gem 'haml-rails'
gem 'jsbundling-rails'
gem 'pagy'
gem 'pg'
gem 'propshaft'
gem 'puma'
gem 'rails', '~> 8.0.2'
gem 'rails-i18n'
gem 'simple_form'
gem 'stimulus-rails'
gem 'thruster', require: false
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[windows jruby]

# gem "image_processing", "~> 1.2"

group :development, :test do
  gem 'brakeman', require: false
  gem 'debug', platforms: %i[mri windows], require: 'debug/prelude'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'haml_lint', require: false
  gem 'html2haml'
  gem 'pg_query'
  gem 'prosopite'
  gem 'rspec-rails'
  gem 'sgcop', github: 'SonicGarden/sgcop', branch: 'main'
end

group :development do
  gem 'annotaterb'
  gem 'letter_opener_web'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'capybara-playwright-driver'
end
