require 'rails_helper'

RSpec.describe AdsController, type: :controller do
  let(:user) {create(:user)}
  let(:valid_attributes) {
    { title: 'New title', description: 'New description', promo: false}
  }

  let(:invalid_attributes) {
    { title: nil, description: nil }
  }

  before do
    payload = { user_id: user.id }
    session = JWTSessions::Session.new(payload: payload)
    @tokens = session.login
  end

  describe "GET #index" do
    let!(:ad) { create(:ad, user: user) }

    it "returns a success response" do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      get :index
      expect(response).to be_successful
      expect(response_json.size).to eq 1
      expect(response_json.first['id']).to eq ad.id
    end

    it "unauth without cookie" do
      get :index
      expect(response).to have_http_status(401)
    end
  end




end
