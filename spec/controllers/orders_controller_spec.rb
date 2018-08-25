# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { create(:user) }
  let(:ad) { create(:ad, user: user) }

  let(:valid_attributes) do
    { name: 'Some name', phone: 'Some phone' }
  end

  let(:invalid_attributes) do
    { name: nil, phone: nil }
  end

  before do
    payload = { user_id: user.id }
    session = JWTSessions::Session.new(payload: payload)
    @tokens = session.login
  end

  describe 'GET #index' do
    let!(:order) { create(:order, user: user, ad: ad) }

    it 'returns a success response' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      get :index
      expect(response).to be_successful
      expect(response_json.size).to eq 1
      expect(response_json.first['id']).to eq order.id
    end

    it 'unauth without cookie' do
      get :index
      expect(response).to have_http_status(401)
    end
  end

end
