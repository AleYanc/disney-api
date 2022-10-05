require 'factory_bot'

RSpec.configure do |config|
    config.include FactoryBot::Syntax::Methods
    FactoryBot.definition_file_paths << File.join(File.dirname(__FILE__), 'factories')
end