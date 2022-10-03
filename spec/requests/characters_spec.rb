require 'rails_helper'

RSpec.describe "Characters", type: :request do
  before(:each) do
    @user = create(:base)
    @token = AuthTokenService.call(1)
    @valid_headers = {"Authorization" => "Token token=#{@token}"}
    @invalid_headers = {"Authorization" => "Token token=#{@token}ASDF"}
    @ch1 = create(:character)
    @ch2 = create(:character)
  end

  after(:each) do
    DatabaseCleaner.clean_with(:truncation)
  end

  describe "GET characters" do
    it "returns character index" do
      get '/api/v1/characters', headers: @valid_headers
      expect(response).to have_http_status(:success)
    end

    it "denies access if token is invalid or non existent" do
      get '/api/v1/characters', headers: @invalid_headers
      expect(response).to have_http_status(:unauthorized)
    end

    it "searches character by name" do
      get '/api/v1/characters', headers: @valid_headers, params: {:by_name => 'Rayo'}
      expect(response).to have_http_status(:success)
      parsed = JSON.parse(response.body)
      expect(parsed.length).to eq(1)
      expect(parsed[0]['name']).to include('Rayo')
    end

    it "searches character by age" do
      get '/api/v1/characters', headers: @valid_headers, params: {:by_age => {from:25,to:35}}
      expect(response).to have_http_status(:success)
      parsed = JSON.parse(response.body)
      expect(parsed.length).to eq(2) #rayo y mate tienen asignado 30 como edad
    end

    it "searches character by weight" do
      get '/api/v1/characters', headers: @valid_headers, params: {:by_weight => {from:600,to:700.98}}
      expect(response).to have_http_status(:success)
      parsed = JSON.parse(response.body)
      expect(parsed.length).to eq(1) #rayo pesa 600.7 y mate 700.99

      get '/api/v1/characters', headers: @valid_headers, params: {:by_weight => {from:600,to:700.99}}
      expect(response).to have_http_status(:success)
      parsed = JSON.parse(response.body)
      expect(parsed.length).to eq(2)
    end

    it "searches character by production" do
      get '/api/v1/characters', headers: @valid_headers, params: {:by_production => 1}
      expect(response).to have_http_status(:success)
      parsed = JSON.parse(response.body)
      expect(parsed.length).to eq(1) #rayo esta relacionado a la produccion 'Cars' cuyo ID es 1, hubo un error al momento de ejecutar la creacion de personaje y mate no quedo asociado
    end
  end

  describe "GET /characters/:id" do
    it "returns a single character based on ID parameter" do
      get "/api/v1/characters/1", headers: @valid_headers
      expect(response).to have_http_status(:success)
      parsed = JSON.parse(response.body)
      expect(parsed['id']).to eq(1)
      expect(parsed['name']).to eq('Rayo McQueen')
    end
  end

  describe "POST /characters" do
    before(:each) do
      @random = build(:random_character)
    end

    it "creates a new character with valid attributes" do
      post "/api/v1/characters", headers: @valid_headers, params: {
        character: {
          name: @random.name, age: @random.age, weight: @random.weight, history: @random.history, image: @random.image, production: @random.productions
        }
      }
      expect(response).to have_http_status(:created)
    end
  end
end