require 'test_helper'

class PayloadsControllerTest < ActionDispatch::IntegrationTest
  test "should get stars" do
    get payloads_stars_url
    assert_response :success
  end

end
