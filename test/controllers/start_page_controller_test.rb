require 'test_helper'

class StartPageControllerTest < ActionDispatch::IntegrationTest
  test "should get greeting" do
    get start_page_greeting_url
    assert_response :success
  end

end
