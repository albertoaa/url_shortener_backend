require 'test_helper'

class RedirectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @redirect = redirects(:one)
  end

  test "should get index" do
    get redirects_url, as: :json
    assert_response :success
  end

  test "should create redirect" do
    assert_difference('Redirect.count') do
      post redirects_url, params: { redirect: { location: @redirect.location, time: @redirect.time } }, as: :json
    end

    assert_response 201
  end

  test "should show redirect" do
    get redirect_url(@redirect), as: :json
    assert_response :success
  end

  test "should update redirect" do
    patch redirect_url(@redirect), params: { redirect: { location: @redirect.location, time: @redirect.time } }, as: :json
    assert_response 200
  end

  test "should destroy redirect" do
    assert_difference('Redirect.count', -1) do
      delete redirect_url(@redirect), as: :json
    end

    assert_response 204
  end
end
