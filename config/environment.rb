# Load the Rails application.
require_relative 'application'

# load configuration before running any initializer file
APPLICATION_CONFIG = YAML.load(File.read(File.expand_path("#{Rails.root}/config/application.yml")))[Rails.env]
SECRET_CONFIG = YAML.load(File.read(File.expand_path("#{Rails.root}/config/secret_keys.yml")))[Rails.env]

# Initialize the Rails application.
Rails.application.initialize!
