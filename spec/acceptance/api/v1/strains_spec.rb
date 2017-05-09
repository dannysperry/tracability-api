# spec/acceptance/v1/strain_spec.rb
require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Strains" do
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

  let(:strain) { build(:strain) }
  let(:id) { strain.save and strain.id }


  get "/v1/strains" do
    example "Listing strains" do
      2.times { create(:strain) }
      do_request
      expect(client.status).to eq(200)
    end
  end

  post "/v1/strains" do
    with_options scope: :strain do
      parameter :name, 'Name of Strain'
      parameter :expected_potency, 'Expected Potency of Strain'
      parameter :expected_yield, 'Expected Yield of Strain'
      parameter :veg_days, 'Veg Days of Strain'
      parameter :flower_days, 'Flower Days of Strain'
    end

    example "Creates a strain" do
      expect {
        do_request({
          strain: attributes_for(:strain)
        })
      }.to change {
        Strain.count
      }.by 1
      expect(client.status).to eq(201)
    end

    let(:name) { nil }
    example_request "Fails to add a strain" do
      expect(client.status).to eq 422
    end
  end

  get "/v1/strains/:id" do
    parameter :id, "Strain ID", required: true

    example_request "Listing a strain" do
      expect(client.status).to eq(200)
    end
  end

  patch "/v1/strains/:id" do
    parameter :id, "Strain ID", required: true

    with_options scope: :strain do
      parameter :name, 'Name of Strain'
      parameter :expected_potency, 'Expected Potency of Strain'
      parameter :expected_yield, 'Expected Yield of Strain'
      parameter :veg_days, 'Veg Days of Strain'
      parameter :flower_days, 'Flower Days of Strain'
    end

    example "Updates a strain" do
      do_request({
        strain: {
          name: strain.name,
          expected_potency: strain.expected_potency,
          expected_yield: strain.expected_yield,
          veg_days: strain.veg_days,
          flower_days: strain.flower_days
        }
      })
      expect(client.status).to eq(200)
    end

    let(:name) { nil }
    example_request "Fails to update a strain" do
      expect(client.status).to eq(422)
    end
  end

  delete "/v1/strains/:id" do
    parameter :id, "Strain ID", required: true

    example_request "Destroys a strain" do
      expect(client.status).to eq(204)
    end
  end
end