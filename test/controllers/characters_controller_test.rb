require "test_helper"

class CharactersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @character = characters(:rayo)
  end

  test "should get index" do
    get api_v1_characters_url, as: :json
    assert_response :success
  end

  test "should create character" do
    assert_difference('Character.count') do
      post api_v1_characters_url, params: { character: { age: 43, history: 'etc', image: @character.image, name: 'Toyota Corolla', weight: 890 } }, as: :json
    end

    assert_response 201
  end

  test "should show character" do
    get api_v1_character_url(@character), as: :json
    assert_response :success
  end

  test "should update character" do
    patch api_v1_character_url(@character), params: { character: { age: @character.age, history: @character.history, image: @character.image, name: @character.name, weight: @character.weight } }, as: :json
    assert_response 200
  end

  test "should destroy character" do
    assert_difference('Character.count', -1) do
      delete api_v1_character_url(@character), as: :json
    end

    assert_response 204
  end
end
