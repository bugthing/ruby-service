require 'bundler/setup'

require 'dotenv'
Dotenv.load

ENVIRONMENT = ENV['ENVIRONMENT'] || 'development'

lib_path = File.expand_path '../../lib', __FILE__
$LOAD_PATH.unshift lib_path

require 'yaml'
settings_file = File.expand_path '../settings.yml', __FILE__
SETTINGS = YAML.load_file(settings_file)[ENVIRONMENT]

require 'pry' if %w[development test].include? ENVIRONMENT

require 'int_serv'
