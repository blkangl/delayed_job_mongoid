require 'simplecov'
require 'coveralls'

SimpleCov.formatters = [SimpleCov::Formatter::HTMLFormatter, Coveralls::SimpleCov::Formatter]

SimpleCov.start do
  add_filter '/spec/'
  minimum_coverage(76.39)
end

require 'rspec'
require 'delayed_job_mongoid'
require 'delayed/backend/shared_spec'
require 'mongoid/compatibility'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.before :all do
    Mongoid.logger.level = Logger::INFO
    Mongo::Logger.logger.level = Logger::INFO if Mongoid::Compatibility::Version.mongoid5? || Mongoid::Compatibility::Version.mongoid6?
  end
end

Mongoid.configure do |config|
  config.connect_to('dl_spec')
end
