# spec/acceptance/v1/room_spec.rb
require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Rooms" do
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

  let(:location) { build(:location) }
  let(:location_id) { location.save and location.id }

  let(:room) { build(:room, location_id: location_id) }
  let(:id) { room.save and room.id }


  get "v1/locations/:location_id/rooms" do
    parameter :location_id, 'Location ID', required: true
    example "Listing rooms" do
      2.times { create(:room, location_id: location_id) }
      do_request
      expect(client.status).to eq(200)
    end
  end

  post "v1/locations/:location_id/rooms" do
    parameter :location_id, 'Location ID', required: true
    with_options scope: :room, required: true do
      parameter :room_type, 'Type of Room'
      parameter :name, 'Name of Room'
      parameter :area_in_inches, 'Area In Inches of Room'
      parameter :is_growing_space, 'Is Growing Space of Room'
    end

    example "Creates a room" do
      location_id
      expect {
        do_request({
          location_id: location_id,
          room: attributes_for(:room)
        })
      }.to change {
        Room.count
      }.by 1
      expect(client.status).to eq(201)
    end

    let(:name) { nil }
    example_request "Fails to add a room" do
      expect(client.status).to eq 422
    end
  end

  get "/v1/rooms/:id" do
    parameter :id, "Room ID", required: true

    example_request "Listing a room" do
      expect(client.status).to eq(200)
    end
  end

  patch "/v1/rooms/:id" do
    parameter :id, "Room ID", required: true

    with_options scope: :room do
      parameter :room_type, 'Type of Room'
      parameter :location_id, 'Location of Room'
      parameter :name, 'Name of Room'
      parameter :area_in_inches, 'Area In Inches of Room'
      parameter :is_growing_space, 'Is Growing Space of Room'
    end

    example "Updates a room" do
      do_request({
        room: {
          room_type: room.room_type,
          location_id: room.location_id,
          name: room.name,
          area_in_inches: room.area_in_inches,
          is_growing_space: room.is_growing_space
        }
      })
      expect(client.status).to eq(200)
    end

    let(:name) { nil }
    example_request "Fails to update a room" do
      expect(client.status).to eq(422)
    end
  end

  delete "/v1/rooms/:id" do
    parameter :id, "Room ID", required: true

    example_request "Destroys a room" do
      expect(client.status).to eq(204)
    end
  end
end