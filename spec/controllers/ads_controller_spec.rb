require 'rails_helper'

RSpec.describe AdsController, type: :controller do
  let(:user) {create(:user)}

  let(:valid_attributes) {
    {  title: 'New title', description: 'New description', promo: false }
  }

  let(:invalid_attributes) {
    { title: nil, description: nil, promo: "dadds" }
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

  describe "GET #show" do
    let!(:ad) { create(:ad, user: user) }

    it 'returns a success response' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      get :show, params: { id: ad.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do

    context 'with valid params' do

      it 'create a new Ad' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        expect {
          post :create, params: { ads: valid_attributes}
        }.to change(Ad, :count).by(1)
      end

      it 'render a JSON response with the new ad' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        post :create, params: { ads: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(ad_url(Ad.last))
      end

      it 'unauth without CSRF' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        post :create, params: { ads: valid_attributes }
        expect(response).to have_http_status(401)
      end

    end

    context "with invalid params" do
      it 'renders a JSON response with errors for the new ad' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        post :create, params: { ads: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end

  end

  describe 'PUT #update' do
    let!(:ad) { create(:ad, user: user) }

    context 'with valid params' do
      let(:new_attributes) {
        { title: 'Secret title' }
      }

      it 'update the requested ad' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        put :update, params: { id: ad.id, ads: new_attributes }
        ad.reload
        expect(ad.title).to eq new_attributes[:title]
      end

      it 'render a JSON response with the ad' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        put :update, params: { id: ad.id, ads: valid_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'with invalid params' do
      it 'render a JSON response with error for the ad' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        put :update, params: { id: ad.id, ads: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end

  end

  describe 'DELETE #destroy' do
    let!(:ad) { create(:ad, user: user) }

    it 'destroys the requested ad' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
      expect {
        delete :destroy, params: { id: ad.id }
    }.to change(Ad, :count).by(-1)
    end
  end

end
