# spec/acceptance/v1/physician_spec.rb
require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Physicians" do
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

  let(:physician) { build(:physician) }
  let(:id) { physician.save and physician.id }


  get "/v1/physicians" do
    example "Listing physicians" do
      2.times { create(:physician) }
      do_request
      expect(client.status).to eq(200)
    end
  end

  post "/v1/physicians" do
    with_options scope: :physician, required: true do
      parameter :name, 'Name of Physician'
      parameter :license_number, 'License Number of Physician'
    end

    example "Creates a physician" do
      expect {
        do_request({
          physician: attributes_for(:physician)
        })
      }.to change {
        Physician.count
      }.by 1
      expect(client.status).to eq(201)
    end

    let(:name) { nil }
    example_request "Fails to add a physician" do
      expect(client.status).to eq 422
    end
  end

  get "/v1/physicians/:id" do
    parameter :id, "Physician ID", required: true

    example_request "Listing a physician" do
      expect(client.status).to eq(200)
    end
  end

  patch "/v1/physicians/:id" do
    parameter :id, "Physician ID", required: true

    with_options scope: :physician do
      parameter :name, 'Name of Physician'
      parameter :license_number, 'License Number of Physician'
    end

    example "Updates a physician" do
      do_request({
        physician: {
          name: physician.name,
          license_number: physician.license_number
        }
      })
      expect(client.status).to eq(200)
    end

    let(:name) { nil }
    example_request "Fails to update a physician" do
      expect(client.status).to eq(422)
    end
  end

  delete "/v1/physicians/:id" do
    parameter :id, "Physician ID", required: true

    example_request "Destroys a physician" do
      expect(client.status).to eq(204)
    end
  end
end