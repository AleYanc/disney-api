require 'rails_helper'

RSpec.describe Api::V1::GenresController, :type => :controller do
  before(:all) do
    @token = AuthTokenService.call(1)
  end

  describe "GET index" do
    it "returns genres index" do
      request.headers["Authorization"] = "Token token=#{@token}"
      get :index
    end

    it "returns character search by name" do
      request.headers["Authorization"] = "Token token=#{@token}"
      get :index , params: {by_name: 'Fairy'}
      parsed = JSON.parse(response.body)
      expect(parsed['data'][0]['attributes']['name']).to include("Fairy tale")
    end
  end

  describe "GET genre" do
    it "returns a single genre" do
      request.headers["Authorization"] = "Token token=#{@token}"
      get :show, params: {id: 1}
      parsed = JSON.parse(response.body)
      expect(parsed.length).to eq(1)
    end

    it "returns error when ID does not exist on DB" do
      request.headers["Authorization"] = "Token token=#{@token}"
      get :show, params: {id: 45}
      parsed = JSON.parse(response.body)
      expect(parsed['error']).to include('No se encuentra el genero con ID:')
    end
  end

  describe "PUT genre" do
    it "should update genre" do
      request.headers["Authorization"] = "Token token=#{@token}"
      old_genre = Genre.find(1)
      patch api_v1_genre_path(1)
      puts response.body
    end
  end
end