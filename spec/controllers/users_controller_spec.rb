require 'rails_helper'

describe UsersController, type: :controller do
  describe '#create' do
    let(:username) { 'Pepito' }

    it 'when they send the username and password and everything goes ok' do
      users = User.count

      post :create, params: { username: username, password: 'ContraseniaPepito123' }

      expect(response).to be_success
      expect(User.count).to eq users + 1
    end

    it 'when we try to create a user but the username was already taken' do
      User.create(username: username, password: 'Apassword123')
      users = User.count

      post :create, params: { username: username, password: 'ContraseniaPepito123' }

      expect(response).not_to be_success
      expect(User.count).to eq users
    end

    it 'when we try to create a user but we missed the password' do
      users = User.count

      post :create, params: { username: username, password: '' }

      expect(response).not_to be_success
      expect(User.count).to eq users
    end

    it 'when we try to create a user but we missed the username' do
      users = User.count

      post :create, params: { username: '', password: 'ContraseniaPepito123' }

      expect(response).not_to be_success
      expect(User.count).to eq users
    end
  end
end
