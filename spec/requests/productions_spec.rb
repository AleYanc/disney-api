require "rails_helper"

RSpec.describe "Productions", type: :request do
  describe "GET productions" do
    it "returns productions index" do
      get "/api/v1/productions", headers: @valid_headers
      expect(response).to have_http_status(:success)
    end

    it "denies access if token is invalid or non existent" do
      get "/api/v1/productions", headers: @invalid_headers
      expect(response).to have_http_status(:unauthorized)
    end

    it "searches production by title" do
      get "/api/v1/productions", headers: @valid_headers, params: { :by_name => "Cars" }
      expect(response).to have_http_status(:success)
      parsed = JSON.parse(response.body)
      expect(parsed['data'].length).to eq(3)
      expect(parsed["data"][0]["attributes"]["title"]).to include("Cars")
    end

    it "searches production by genre" do
      get "/api/v1/productions", headers: @valid_headers, params: { :genre => 1 }
      expect(response).to have_http_status(:success)
      parsed = JSON.parse(response.body)
      expect(parsed['data'].length).to eq(3) # las tres producciones creadas en el spec_helper tienen asignadas el primer genero de la DB
    end

    it "searches production by score" do
      get "/api/v1/productions", headers: @valid_headers, params: { :score => 5 }
      expect(response).to have_http_status(:success)
      parsed = JSON.parse(response.body)
      expect(parsed['data'].length).to eq(2)

      get "/api/v1/productions", headers: @valid_headers, params: { :score => 3 }
      expect(response).to have_http_status(:success)
      parsed = JSON.parse(response.body)
      expect(parsed['data'].length).to eq(1)
    end
  end

  describe "GET /productions/:id" do
    it "returns a single production based on ID parameter" do
      get "/api/v1/productions/1", headers: @valid_headers
      expect(response).to have_http_status(:success)
      parsed = JSON.parse(response.body)
      expect(parsed["data"]["id"].to_i).to eq(1)
      expect(parsed["data"]["attributes"]["title"]).to eq("Cars")
    end
  end

  describe "POST /productions" do
    before(:each) do
      @random = build(:rand_production)
    end

    it "creates a new production with valid attributes" do
      post "/api/v1/productions", headers: @valid_headers, params: {
                                    title: @random.title, released_date: @random.released_date, score: @random.score, image: @random.image, genre: @random.genres,
                                  }
      expect(response).to have_http_status(:created)
    end

    it "returns error when one or more attributes are missing" do
      post "/api/v1/productions", headers: @valid_headers, params: {
                                    title: nil, released_date: nil, score: @random.score, image: @random.image, genre: @random.genres,
                                  }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "DELETE /productions" do
    it "deletes a propduction" do
      expect {
        delete "/api/v1/productions/#{@production.id}", headers: @valid_headers
      }.to change { Production.count }.by(-1)
    end

    it "returns error when an invalid ID is passed" do
      delete "/api/v1/productions/44", headers: @valid_headers
      parsed = JSON.parse(response.body)
      expect(parsed["error"]).to eq("No se encuentra la produccion con ID: '44'")
    end
  end
end
