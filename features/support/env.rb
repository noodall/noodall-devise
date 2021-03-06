ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../../spec/dummy/config/environment.rb",  __FILE__)

require 'cucumber/rails/action_controller'
require 'action_dispatch/testing/test_process'
require 'action_dispatch/testing/integration'
require 'cucumber/rails/world'
require 'cucumber/rails/hooks'
require 'cucumber/rails/capybara'

require 'cucumber/web/tableish'
require 'cucumber/rspec/doubles'

# Capybara defaults to XPath selectors rather than Webrat's default of CSS3. In
# order to ease the transition to Capybara we set the default here. If you'd
# prefer to use XPath just remove this line and adjust any selectors in your
# steps to use the XPath syntax.
Capybara.default_selector = :css

# If you set this to false, any error raised from within your app will bubble
# up to your step definition and out to cucumber unless you catch it somewhere
# on the way. You can make Rails rescue errors and render error pages on a
# per-scenario basis by tagging a scenario or feature with the @allow-rescue tag.
#
# If you set this to true, Rails will rescue all errors and render error
# pages, more or less in the same way your application would behave in the
# default production environment. It's not recommended to do this for all
# of your scenarios, as this makes it hard to discover errors in your application.
ActionController::Base.allow_rescue = false

# How to clean your database when transactions are turned off. See
# http://github.com/bmabey/database_cleaner for more info.
require 'database_cleaner'
require 'database_cleaner/cucumber'
DatabaseCleaner.strategy = :truncation

require 'factory_girl'

Factory.definition_file_paths = [
  File.expand_path("../../../spec/factories",  __FILE__)
]
Factory.find_definitions

require 'factory_girl/step_definitions'
