require "rails_helper"

RSpec.describe "Auth", type: :request do
  describe 'POST /auth' do
    it "returns token when the user logs in" do
      post '/api/v1/auth', params: {email: @user.email, password: @user.password}
      expect(response).to have_http_status(:success)
      expect(response.body).to include('token')
    end
  end
end