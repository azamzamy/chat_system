# /tests/integration/routes_test.rb
require 'test_helper'

class RoutesTest < ActionController::IntegrationTest
  test "route test" do
    assert_generates "/", { :controller => "applications", :action => "show", :token => "mT3E2vJPyZZCkvQGqvnjzdAw" }
    assert_generates "/", :controller => "chats", :action => "index"
  end
end