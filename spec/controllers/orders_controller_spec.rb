require 'rails_helper'
RSpec.describe OrdersController, type: :controller do
  let(:user) { create(:user) }
  let(:ad) { create(:ad, user: user) }


  let(:valid_attributes) {
    { owner_name: 'Name', owner_phone: 854785599, ad_id: ad.id }
  }

  let(:invalid_attributes) {
    { owner_name: nil, owner_phone: nil }
  }

  before do
    payload = { user_id: user.id }
    session = JWTSessions::Session.new(payload: payload)
    @tokens = session.login
  end

  describe 'GET #index' do
    let!(:order) { create(:order, user: user) }

    it 'returns a success response' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      get :index
      expect(response).to be_successful
      expect(response_json.size).to eq 1
      expect(response_json.first['id']).to eq order.id
    end

    it 'unauth error response' do
      get :index
      expect(response).to have_http_status(401)
    end
  end

  describe 'GET #show' do
    let!(:order) { create(:order, user: user) }

    it "returns a success response" do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      get :show, params: { id: order.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context "with valid params" do
      it 'create a new Order' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        expect do
          post :create, params: { order: valid_attributes }
        end.to change(Order, :count).by(1)
      end
    end
    
  end
  

end
