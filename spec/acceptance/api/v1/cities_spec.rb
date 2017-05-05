# spec/acceptance/v1/city_spec.rb
require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Cities" do
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

  let(:state) { build(:state) }
  let(:state_id) { state.save and state.id }

  let(:city) { build(:city, state_id: state_id) }
  let(:id) { city.save and city.id }

  get "/v1/states/:state_id/cities" do
    parameter :state_id, 'State ID', required: true

    example "Listing cities" do
      2.times { create(:city) }
      do_request
      expect(client.status).to eq(200)
    end
  end

  post "/v1/states/:state_id/cities" do
    parameter :state_id, 'State ID', required: true
    with_options scope: :city do
      parameter :name, 'Name of City', required: true
    end

    example "Creates a city" do
      expect {
        do_request({
          state_id: create(:state).id,
          city: {
            name: "fake name"
          }
        })
      }.to change {
        City.count
      }.by 1
      expect(client.status).to eq(201)
    end

    let!(:city_name) { nil }
    example_request "Fails to add a city" do
      expect(client.status).to eq 422
    end
  end

  get "/v1/cities/:id" do
    parameter :id, "City ID", required: true

    example_request "Listing a city" do
      expect(client.status).to eq(200)
    end
  end

  patch "/v1/cities/:id" do
    parameter :id, "City ID", required: true

    with_options scope: :city do
      parameter :state_id, "State ID"
      parameter :name, 'Name of City'
    end

    example "Updates a city" do
      do_request({
        city: {
          name: "name name name"
        }
      })
      expect(client.status).to eq(200)
    end

    let!(:city_name) { nil }
    example_request "Fails to update a city" do
      expect(client.status).to eq(422)
    end
  end

  delete "/v1/cities/:id" do
    parameter :id, "City ID", required: true

    example_request "Destroys a city" do
      expect(client.status).to eq(204)
    end
  end
end