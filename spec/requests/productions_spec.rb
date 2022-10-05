require 'rails_helper'

RSpec.describe "Productions", type: :request do
  describe "GET index" do
    it "should return productions with score scope" do
      get '/api/v1/productions', headers: @valid_headers, params: {:score => 5}
    end
  end
end