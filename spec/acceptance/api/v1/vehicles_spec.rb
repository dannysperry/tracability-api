# spec/acceptance/v1/vehicle_spec.rb
require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Vehicles" do
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

  let(:vehicle) { build(:vehicle, license_id: license_id) }
  let(:id) { vehicle.save and vehicle.id }


  get "v1/licenses/:license_id/vehicles" do
    parameter :license_id, 'License ID', required: true
    example "Listing vehicles" do
      2.times { create(:vehicle) }
      do_request
      expect(client.status).to eq(200)
    end
  end

  post "v1/licenses/:license_id/vehicles" do
    parameter :license_id, 'License ID', required: true
    with_options scope: :vehicle do
      parameter :license, 'License of Vehicle'
      parameter :vin, 'Vehicle VIN'
      parameter :make, "Vechile Make", required: true
      parameter :model, "Vehicle Model", required: true
      parameter :year, "Vehicle Year", required: true
      parameter :color, "Color of Vehicle", required: true
    end

    example "Creates a vehicle" do
      expect {
        do_request({
          vehicle: attributes_for(:vehicle)
        })
      }.to change {
        Vehicle.count
      }.by 1
      expect(client.status).to eq(201)
    end

    let(:make) { nil }
    example_request "Fails to add a vehicle" do
      expect(client.status).to eq 422
    end
  end

  get "/v1/vehicles/:id" do
    parameter :id, "Vehicle ID", required: true

    example_request "Listing a vehicle" do
      expect(client.status).to eq(200)
    end
  end

  patch "/v1/vehicles/:id" do
    parameter :id, "Vehicle ID", required: true

    with_options scope: :vehicle do
      parameter :license_id, 'License of Vehicle'
      parameter :vin, 'Vehicle VIN'
      parameter :make, "Vechile Make"
      parameter :model, "Vehicle Model"
      parameter :year, "Vehicle Year"
      parameter :color, "Color of Vehicle"
    end

    example "Updates a vehicle" do
      license_id
      do_request({
        vehicle: {
          vin: Faker::Vehicle.vin,
          make: "something test",
          model: "kind of something test",
          year: 2050
        }
      })
      expect(client.status).to eq(200)
    end

    let(:make) { nil }
    example_request "Fails to update a vehicle" do
      expect(client.status).to eq(422)
    end
  end

  delete "/v1/vehicles/:id" do
    parameter :id, "Vehicle ID", required: true

    example_request "Destroys a vehicle" do
      expect(client.status).to eq(204)
    end
  end
end