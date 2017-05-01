# spec/acceptance/v1/inventory_type_spec.rb
require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "InventoryTypes" do
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

  let(:inventory_type)    { build(:inventory_type) }
  let(:id) { inventory_type.save and inventory_type.id }

  get "/v1/inventory_types" do
    example "Listing inventory_types" do
      2.times { create(:inventory_type) }
      do_request
      expect(client.status).to eq(200)
    end
  end

  get "/v1/inventory_types/:id" do
    parameter :id, "InventoryType ID", required: true

    example_request "Listing a inventory_type" do
      expect(client.status).to eq(200)
    end
  end

  post "/v1/inventory_types" do
    with_options scope: :inventory_type do
      parameter :name, 'Name of InventoryType', required: true
    end

    example "Creates a inventory_type" do
      expect {
        do_request({
          inventory_type: attributes_for(:inventory_type)
        })
      }.to change {
        InventoryType.count
      }.by 1
      expect(client.status).to eq(201)
    end

    let(:name) { nil }
    example_request "Fails to add a inventory_type" do
      do_request
      expect(client.status).to eq 422
    end
  end

  patch "/v1/inventory_types/:id" do
    parameter :id, "InventoryType ID", required: true

    with_options scope: :inventory_type do
      parameter :name, 'Name of InventoryType', required: true
    end

    example "Updates a inventory_type" do
      do_request({
        inventory_type: {
          name: inventory_type.name
        }
      })
      expect(client.status).to eq(200)
    end

    let(:name) { nil }
    example_request "Fails to update a inventory_type" do
      expect(client.status).to eq(422)
    end
  end

  delete "/v1/inventory_types/:id" do
    parameter :id, "InventoryType ID", required: true

    example_request "Destroys a inventory_type" do
      expect(client.status).to eq(204)
    end
  end
end