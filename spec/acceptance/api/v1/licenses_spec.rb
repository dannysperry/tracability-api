# spec/acceptance/v1/license_spec.rb
require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Licenses" do
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

  let(:license) { build(:license, state_id: state_id) }
  let(:id) { license.save and license.id }

  get "v1/states/:state_id/licenses" do
    parameter :state_id, 'State ID', required: true
    example "Listing licenses" do
      2.times { create(:license, state_id: state_id) }
      do_request
      expect(client.status).to eq(200)
    end
  end

  post "v1/states/:state_id/licenses" do
    parameter :state_id, 'State ID', required: true
    with_options scope: :license do
      parameter :license_number, 'License Number of License', required: true
      parameter :license_type, 'License Number of License', required: true
    end


    example "Creates a license" do
      state_id
      expect {
        do_request({
          state_id: state_id,
          license: attributes_for(:license, state_id: state_id)
        })
      }.to change {
        License.count
      }.by 1
      expect(client.status).to eq(201)
    end

    let(:license_number) { nil }
    example_request "Fails to add a license" do
      expect(client.status).to eq 422
    end
  end

  get "/v1/licenses/:id" do
    parameter :id, "License ID", required: true

    example_request "Listing a license" do
      expect(client.status).to eq(200)
    end
  end

  patch "/v1/licenses/:id" do
    parameter :id, "License ID", required: true

    with_options scope: :license do
      parameter :license_number, 'License Number of License'
      parameter :license_type, 'License Number of License'
      parameter :state_id, 'State ID'
    end

    example "Updates a license" do
      do_request({
        license: {
          license_number: license.license_number,
          license_type: [:processor, :producer, :retailer].sample,
          state_id: state_id
        }
      })
      expect(client.status).to eq(200)
    end

    let(:license_number) { nil }
    example_request "Fails to update a license" do
      expect(client.status).to eq(422)
    end
  end

  delete "/v1/licenses/:id" do
    parameter :id, "License ID", required: true

    example_request "Destroys a license" do
      expect(client.status).to eq(204)
    end
  end
end