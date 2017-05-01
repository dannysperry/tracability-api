# spec/acceptance/v1/users_spec.rb
require 'rails_helper'
require 'rspec_api_documentation/dsl'


resource "Users" do
  let(:user) { create(:user) }
  let(:id) { user.id }
  let(:auth_tokens) { user.confirm && user.create_new_auth_token }

  header "Accept", "application/json"

  let(:auth_access_token) { auth_tokens['access-token'] }
  let(:auth_token_type)   { auth_tokens['token-type'] }
  let(:auth_client)       { auth_tokens['client'] }
  let(:auth_expiry)       { auth_tokens['expiry'] }
  let(:auth_uid)          { auth_tokens['uid'] }

  # A specific endpoint
  get "/v1/users" do
    header "access-token", :auth_access_token
    header "token-type", :auth_token_type
    header "client", :auth_client
    header "expiry", :auth_expiry
    header "uid", :auth_uid

    example "Listing Users" do
      2.times { create(:user) }
      do_request
      expect(client.status).to eq(200)
    end
  end

  get "/v1/users/:id" do
    header "access-token", :auth_access_token
    header "token-type", :auth_token_type
    header "client", :auth_client
    header "expiry", :auth_expiry
    header "uid", :auth_uid

    parameter :id, "User ID", required: true

    example_request "Listing Single User" do
      expect(client.status).to eq(200)
    end
  end

  post '/auth' do
    parameter :email, "A unique email address that no other Users have", required: true
    parameter :password, "A secret password", required: true
    parameter :password_confirmation, "An exact match to the password parameter", required: true
    parameter :confirm_success_url, "The url a user will redirect to after confirming their account", required: true

    example "Creates or registers a User" do
      do_request({
        email: "test#{SecureRandom.hex(6)}@test.com",
        password: "testpassword1",
        password_confirmation: "testpassword1",
        confirm_success_url: "http://localhost:3000"
      })

      expect(client.status).to eq 200
    end

    example "Fails to create or register a User with a non unique email" do

      do_request({
        email: user.email,
        password: "testpassword1",
        password_confirmation: "testpassword1",
        confirm_success_url: "http://localhost:3000"
      })

      expect(client.status).to eq 422
    end

    example "Fails to create or register a User with a non matching password" do
      do_request({
        email: "test#{SecureRandom.hex(6)}@test.com",
        password: "testpassword1",
        password_confirmation: "thisdoesntmatch",
        confirm_success_url: "http://localhost:3000"
      })

      expect(client.status).to eq 422
    end
  end

  post '/auth/sign_in' do
    parameter :email, "A valid email address of a registered user", required: true
    parameter :password, "A valid password for the associated users email", required: true

    example 'Signs a User in' do
      explanation "request authentication headers with a registered and confirmed User's authentication credentials"
      user.confirm
      do_request({ email: user.email, password: user.password })

      expect(client.status).to eq 200
    end

    example 'Signs a User in fails with a unconfirmed or unregistered User' do
      explanation "request authentication headers with a registered and confirmed User's authentication credentials"

      do_request({ email: user.email, password: user.password })

      expect(client.status).to eq 401
    end
  end
end
