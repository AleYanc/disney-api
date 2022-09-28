require "test_helper"

class CharactersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @character = characters(:rayo)
    user = users(:base)
    @token = AuthTokenService.call(user.id)
  end

  test "should get index" do
    get api_v1_characters_url,
    headers: {'HTTP_AUTHORIZATION': "Token token=#{@token}"},
    as: :json
    assert_response :success
  end

  test "should create character" do
    assert_difference("Character.count") do
      post api_v1_characters_url, 
      params: { 
        character: { age: 43, history: "etc", image: @character.image, name: "Toyota Corolla", weight: 890 } 
        }, 
      headers: {'HTTP_AUTHORIZATION': "Token token=#{@token}"}, 
      as: :json
    end

    assert_response 201
  end

  test "should show character" do
    get api_v1_character_url(@character), 
    headers: {'HTTP_AUTHORIZATION': "Token token=#{@token}"},
    as: :json
    assert_response :success
  end

  test "should update character" do
    patch api_v1_character_url(@character), 
    params: { 
      character: { age: 76, history: @character.history, image: @character.image, name: @character.name, weight: @character.weight } 
      },
    headers: {'HTTP_AUTHORIZATION': "Token token=#{@token}"}, 
    as: :json
    assert_response 200
  end

  test "should destroy character" do
    assert_difference("Character.count", -1) do
      delete api_v1_character_url(@character),
      headers: {'HTTP_AUTHORIZATION': "Token token=#{@token}"},
      as: :json
    end

    assert_response 204
  end

  test "should return unauthorized if token is invalid or nonexistent" do
    get api_v1_characters_url,
    headers: {'HTTP_AUTHORIZATION': "Token token=#{@token}34"}
    assert_response 401
    assert_includes "You are not authorized to perform that action", JSON.parse(response.body)["msg"]
  end
end
