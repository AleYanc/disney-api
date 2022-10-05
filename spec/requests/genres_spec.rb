require "rails_helper"

RSpec.describe "Genres", type: :request do
  describe "GET genres" do
    it "returns genres index" do
      get "/api/v1/genres", headers: @valid_headers
      expect(response).to have_http_status(:success)
    end

    it "denies access if token is invalid or non existent" do
      get "/api/v1/genres", headers: @invalid_headers
      expect(response).to have_http_status(:unauthorized)
    end

    it "searches genre by name" do
      get "/api/v1/genres", headers: @valid_headers, params: { :by_name => "Aventura" }
      expect(response).to have_http_status(:success)
      parsed = JSON.parse(response.body)
      expect(parsed['data'].length).to eq(1)
      expect(parsed["data"][0]["attributes"]["name"]).to eq("Aventura")
    end
  end

  describe "GET /genres/:id" do
    it "returns a single genre based on ID parameter" do
      get "/api/v1/genres/1", headers: @valid_headers
      expect(response).to have_http_status(:success)
      parsed = JSON.parse(response.body)
      expect(parsed["data"]["id"].to_i).to eq(1)
      expect(parsed["data"]["attributes"]["name"]).to eq("Aventura")
    end
  end

  describe "POST /productions" do
    before(:each) do
      @random = build(:genre)
    end

    it "creates a new genre with valid attributes" do
      post "/api/v1/genres", headers: @valid_headers, params: {
                              name: @random.name, image: @random.image,
                             }
      expect(response).to have_http_status(:created)
    end

    it "returns error when one or more attributes are missing" do
      post "/api/v1/genres", headers: @valid_headers, params: {
                               name: nil, image: @random.image,
                             }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "DELETE /genres" do
    it "deletes a genre" do
      expect {
        delete "/api/v1/genres/#{@genre.id}", headers: @valid_headers
      }.to change { Genre.count }.by(-1)
    end

    it "returns error when an invalid ID is passed" do
      delete "/api/v1/genres/44", headers: @valid_headers
      parsed = JSON.parse(response.body)
      expect(parsed['error']).to eq("No se encuentra el genero con ID: '44'")
    end
  end
end
