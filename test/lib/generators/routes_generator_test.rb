require "test_helper"
require "generators/routes/routes_generator"

class RoutesGeneratorTest < Rails::Generators::TestCase
  tests RoutesGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end