# spec/acceptance/v1/state_spec.rb
require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "States" do
  let(:user) { create(:user) }
  let(:auth_tokens) { user.confirm && user.create_new_auth_token }

  let(:auth_access_token) { auth_tokens['access-token'] }
  let(:auth_token_type)   { auth_tokens['token-type'] }
  let(:auth_client)       { auth_tokens['client'] }
  let(:auth_expiry)       { auth_tokens['expiry'] }
  let(:auth_uid)          { auth_tokens['uid'] }

  header "access-token", :auth_access_token
  header "token-type", :auth_token_type
  header "client", :auth_client
  header "expiry", :auth_expiry
  header "uid", :auth_uid

  let(:state)    { build(:state) }
  let(:id) { state.save and state.id }

  get "/v1/states" do
    example "Listing states" do
      2.times { create(:state) }
      do_request
      expect(client.status).to eq(200)
    end
  end

  get "/v1/states/:id" do
    parameter :id, "State ID", required: true

    example_request "Listing a state" do
      expect(client.status).to eq(200)
    end
  end

  post "/v1/states" do
    with_options scope: :state do
      parameter :name, 'Name of State', required: true
      parameter :abbreviation, 'Abbreviation of State', required: true
    end

    example "Creates a state" do
      expect {
        do_request({
          state: attributes_for(:state)
        })
      }.to change {
        State.count
      }.by 1
      expect(client.status).to eq(201)
    end

    let(:name) { nil }
    example_request "Fails to add a state" do
      do_request
      expect(client.status).to eq 422
    end
  end

  patch "/v1/states/:id" do
    parameter :id, "State ID", required: true

    with_options scope: :state do
      parameter :name, 'Name of State', required: true
      parameter :abbreviation, 'Abbreviation of State', required: true
    end

    example "Updates a state" do
      do_request({
        state: {
          name: state.name,
          abbreviation: state.abbreviation
        }
      })
      expect(client.status).to eq(200)
    end

    let(:name) { nil }
    example_request "Fails to update a state" do
      expect(client.status).to eq(422)
    end
  end

  delete "/v1/states/:id" do
    parameter :id, "State ID", required: true

    example_request "Destroys a state" do
      expect(client.status).to eq(204)
    end
  end
end