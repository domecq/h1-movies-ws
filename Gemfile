source 'https://rubygems.org'

gem 'rails', '3.2.0'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'


group :development, :test do
  gem 'mysql2'
end
group :production do
  gem 'pg'
end
group :production do
  gem 'thin'
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
#  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
gem 'activeadmin', :git => 'git://github.com/gregbell/active_admin.git'
gem 'sass-rails'
gem "meta_search",    '>= 1.1.0.pre'
gem "nokogiri"
gem "geocoder", :git => 'git://github.com/alexreisner/geocoder.git'

#testing

gem 'rspec-rails', :group => [:test, :development]
group :test do
	gem "factory_girl_rails"
	gem "capybara"
	gem "guard-rspec"
end

