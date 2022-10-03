require 'rails_helper'

RSpec.describe Api::V1::CharactersController, :type => :controller do
  before(:all) do
    @token = AuthTokenService.call(1)
  end

  describe "GET index" do
    it "returns character index" do
      request.headers["Authorization"] = "Token token=#{@token}"
      get :index
    end

    it "returns character search by name" do
      request.headers["Authorization"] = "Token token=#{@token}"
      get :index , params: {by_name: 'Rayo'}
      parsed = JSON.parse(response.body)
      expect(parsed[0]["name"]).to include("Rayo")
    end

    it "returns character search by age" do
      request.headers["Authorization"] = "Token token=#{@token}"
      get :index , params: {by_age: {from: 30, to: 100}}
      parsed = JSON.parse(response.body)
      expect(parsed[0]["name"]).to include("Rayo")
    end

    it "returns character search by weight" do
      request.headers["Authorization"] = "Token token=#{@token}"
      get :index , params: {by_weight: {from: 600.6, to: 600.7}}
      parsed = JSON.parse(response.body)
      expect(parsed[0]["name"]).to include("Rayo")
    end

    it "returns character search by production" do
      request.headers["Authorization"] = "Token token=#{@token}"
      get :index , params: {by_production: 1} #id 1 es el creado por FactoryBot, pelicula Cars
      parsed = JSON.parse(response.body)
      expect(parsed[0]["name"]).to include("Rayo")
    end
  end
end