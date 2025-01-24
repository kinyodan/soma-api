require 'factory_bot_rails'
# spec/spec_helper.rb
RSpec.configure do |config|
    # Use the specified formatter
    config.formatter = :documentation
  
    # Disable RSpec exposing methods globally on `Module` and `main`
    config.disable_monkey_patching!
  
    # Run specs in random order to surface order dependencies
    config.order = :random
  
    # Seed global randomization in this process using the `--seed` CLI option
    Kernel.srand config.seed
  
    # Configure RSpec to include FactoryBot syntax
    config.include FactoryBot::Syntax::Methods
  
    # Expectation configuration
    config.expect_with :rspec do |c|
      c.syntax = :expect
    end
  end
  