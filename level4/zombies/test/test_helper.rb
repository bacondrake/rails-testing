require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  # Used to be in the model/zombie_test.rb file, but moving it here meanas that it can be used with other models (like tweets)
  # The shoulda gem has this kind of presence validation method already, so this method is here just as an example.
  # The model parameter in this case is the actual model (e.g. zombie), the field is what's being validated (e.g. name, graveyard)
  def assert_presence(model, field)
    model.valid?
    assert_match /can't be blank/, model.errors[field].join, "Presence error for #{field} not found on #{model.class}"
  end
end

require 'mocha/mini_test'