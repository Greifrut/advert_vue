# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  before { sign_in_as(user) }

  describe 'GET :me' do
    it 'return a success response' do
      get :me
      expect(response).to be_successful
      expect(response_json).to eq user.as_json(only: %i[id email])
    end
  end
end
