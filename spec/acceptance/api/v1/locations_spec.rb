# spec/acceptance/v1/location_spec.rb
require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Locations" do
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

  let(:license) { build(:license) }
  let(:license_id) { license.save and license.id }

  let(:location) { build(:location, license_id: license_id) }
  let(:id) { location.save and location.id }


  get "v1/licenses/:license_id/locations" do
    parameter :license_id, 'License ID', required: true
    example "Listing locations" do
      2.times { create(:location, license_id: license_id) }
      do_request
      expect(client.status).to eq(200)
    end
  end

  post "v1/licenses/:license_id/locations" do
    parameter :license_id, 'License ID', required: true
    with_options scope: :location do
      parameter :city_id, 'City ID'
      parameter :name, 'Name of Location', required: true
      parameter :street_address, 'Street Address of Location', required: true
      parameter :phone_number, 'Phone Number of Location'
      parameter :area_in_inches, 'Area In Square Inches of Location', required: true
    end

    example "Creates a location" do
      expect {
        do_request({
          license_id: license_id,
          location: location.attributes
        })
      }.to change {
        Location.count
      }.by 1
      expect(client.status).to eq(201)
    end

    let(:name) { nil }
    example_request "Fails to add a location" do
      expect(client.status).to eq 422
    end
  end

  get "/v1/locations/:id" do
    parameter :id, "Location ID", required: true

    example_request "Listing a location" do
      expect(client.status).to eq(200)
    end
  end

  patch "/v1/locations/:id" do
    parameter :id, "Location ID", required: true

    with_options scope: :location do
      parameter :license_id, 'License of Location'
      parameter :city_id, 'City of Location'
      parameter :name, 'Name of Location'
      parameter :street_address, 'Street Address of Location'
      parameter :phone_number, 'Phone Number of Location'
      parameter :area_in_inches, 'Area In Inches of Location'
    end

    example "Updates a location" do
      do_request({
        location: {
          license_id: license_id,
          city_id: location.city.id,
          name: "updated name",
          street_address: "555 new address st.",
          phone_number: "555-555-5556",
          area_in_inches: location.area_in_inches
        }
      })
      expect(client.status).to eq(200)
    end

    let(:name) { nil }
    example_request "Fails to update a location" do
      expect(client.status).to eq(422)
    end
  end

  delete "/v1/locations/:id" do
    parameter :id, "Location ID", required: true

    example_request "Destroys a location" do
      expect(client.status).to eq(204)
    end
  end
end