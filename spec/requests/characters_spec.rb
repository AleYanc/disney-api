require "rails_helper"

RSpec.describe "Characters", type: :request do
  describe "GET characters" do
    it "returns character index" do
      get "/api/v1/characters", headers: @valid_headers
      expect(response).to have_http_status(:success)
    end

    it "denies access if token is invalid or non existent" do
      get "/api/v1/characters", headers: @invalid_headers
      expect(response).to have_http_status(:unauthorized)
    end

    it "searches character by name" do
      get "/api/v1/characters", headers: @valid_headers, params: { :by_name => "Rayo" }
      expect(response).to have_http_status(:success)
      parsed = JSON.parse(response.body)
      expect(parsed['data'].length).to eq(1)
      expect(parsed["data"][0]["attributes"]["name"]).to include("Rayo")
    end

    it "searches character by age" do
      get "/api/v1/characters", headers: @valid_headers, params: { :by_age => { from: 25, to: 35 } }
      expect(response).to have_http_status(:success)
      parsed = JSON.parse(response.body)
      expect(parsed['data'].length).to eq(2) #rayo y mate tienen asignado 30 como edad
    end

    it "searches character by weight" do
      get "/api/v1/characters", headers: @valid_headers, params: { :by_weight => { from: 600, to: 700.98 } }
      expect(response).to have_http_status(:success)
      parsed = JSON.parse(response.body)
      expect(parsed['data'].length).to eq(1) #rayo pesa 600.7 y mate 700.99

      get "/api/v1/characters", headers: @valid_headers, params: { :by_weight => { from: 600, to: 700.99 } }
      expect(response).to have_http_status(:success)
      parsed = JSON.parse(response.body)
      expect(parsed['data'].length).to eq(2)
    end

    it "searches character by production" do
      get "/api/v1/characters", headers: @valid_headers, params: { :by_production => 1 }
      expect(response).to have_http_status(:success)
      parsed = JSON.parse(response.body)
      expect(parsed['data'].length).to eq(2) #rayo y mate estan asociados a la primer produccion que se crea cuyo ID siempre sera 1 en este contexto
    end
  end

  describe "GET /characters/:id" do
    it "returns a single character based on ID parameter" do
      get "/api/v1/characters/1", headers: @valid_headers
      expect(response).to have_http_status(:success)
      parsed = JSON.parse(response.body)
      expect(parsed["data"]["id"].to_i).to eq(1)
      expect(parsed["data"]["attributes"]["name"]).to eq("Rayo McQueen")
    end
  end

  describe "POST /characters" do
    before(:each) do
      @random = build(:random_character)
    end

    it "creates a new character with valid attributes" do
      post "/api/v1/characters", headers: @valid_headers, params: {
                                   name: @random.name, age: @random.age, weight: @random.weight, history: @random.history, image: @random.image, production: @random.productions,
                                 }
      expect(response).to have_http_status(:created)
    end

    it "returns error when one or more attributes are missing" do
      post "/api/v1/characters", headers: @valid_headers, params: {
                                   name: nil, age: @random.age, weight: @random.weight, history: @random.history, image: @random.image, production: @random.productions,
                                 }
      expect(response).to have_http_status(422)
    end
  end

  describe "DELETE /characters" do
    it "deletes character" do
      expect {
        delete "/api/v1/characters/#{@ch1.id}", headers: @valid_headers
      }.to change { Character.count }.by(-1)
    end

    it "returns error when an invalid ID is passed" do
      delete "/api/v1/characters/44", headers: @valid_headers
      parsed = JSON.parse(response.body)
      expect(parsed["error"]).to eq("No se encuentra el personaje con ID: '44'")
    end
  end
end
