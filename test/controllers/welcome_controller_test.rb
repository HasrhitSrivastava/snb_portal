require "test_helper"

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url    
    assert_response :success
  end

  test "should get contact" do
    get contact_url
    assert_response :success
  end

  test "should get discover_more" do
    get discover_more_url
    assert_response :success
  end

  test "should get admission" do
    get admission_url
    assert_response :success
  end

  test "should get academic" do
    get academic_url
    assert_response :success
  end
end
