require "test_helper"

class ProductionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @production = productions(:cars)
  end

  test "should get index" do
    get productions_url, as: :json
    assert_response :success
  end

  test "should create production" do
    assert_difference('Production.count') do
      post productions_url, params: { production: { image: @production.image, released_date: @production.released_date, score: @production.score, title: @production.title } }, as: :json
    end

    assert_response 201
  end

  test "should show production" do
    get production_url(@production), as: :json
    assert_response :success
  end

  test "should update production" do
    patch production_url(@production), params: { production: { image: @production.image, released_date: @production.released_date, score: @production.score, title: @production.title } }, as: :json
    assert_response 200
  end

  test "should destroy production" do
    assert_difference('Production.count', -1) do
      delete production_url(@production), as: :json
    end

    assert_response 204
  end
end
