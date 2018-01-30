require 'test_helper'

class CustomControllerTest < ActionDispatch::IntegrationTest
  test "should get webhookCreateaorder" do
    get custom_webhookCreateaorder_url
    assert_response :success
  end

end
