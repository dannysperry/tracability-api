# spec/acceptance/v1/room_section_spec.rb
require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "RoomSections" do
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

  let(:room) { build(:room) }
  let(:room_id) { room.save and room.id }

  let(:room_section) { build(:room_section, room_id: room_id) }
  let(:id) { room_section.save and room_section.id }


  get "v1/rooms/:room_id/room_sections" do
    parameter :room_id, 'Room ID', required: true
    example "Listing room_sections" do
      2.times { create(:room_section, room_id: room_id) }
      do_request
      expect(client.status).to eq(200)
    end
  end

  post "v1/rooms/:room_id/room_sections" do
    parameter :room_id, 'Room ID', required: true
    with_options scope: :room_section do
      parameter :section_type, 'Type of Section', required: true
      parameter :name, 'Name of Section', required: true
      parameter :area_in_inches, 'Area In Square Inches of Section', required: true
      parameter :is_growing_space, 'Is Section a Growing Space?'
    end

    example "Creates a room_section" do
      room_id
      expect {
        do_request({
          room_id: room_id,
          room_section: attributes_for(:room_section)
        })
      }.to change {
        RoomSection.count
      }.by 1
      expect(client.status).to eq(201)
    end

    let(:name) { nil }
    example_request "Fails to add a room_section" do
      expect(client.status).to eq 422
    end
  end

  get "/v1/room_sections/:id" do
    parameter :id, "RoomSection ID", required: true

    example_request "Listing a room_section" do
      expect(client.status).to eq(200)
    end
  end

  patch "/v1/room_sections/:id" do
    parameter :id, "RoomSection ID", required: true

    with_options scope: :room_section do
      parameter :section_type, 'Type of Section'
      parameter :name, 'Name of Section'
      parameter :area_in_inches, 'Area In Square Inches of Section'
      parameter :is_growing_space, 'Is Section a Growing Space?'
      parameter :room_id, 'Room ID'
    end

    example "Updates a room_section" do
      do_request({
        room_section: {
          name: room_section.name,
          area_in_inches: room_section.area_in_inches,
          section_type: room_section.section_type,
          is_growing_space: room_section.is_growing_space,
          room_id: room_id
        }
      })
      expect(client.status).to eq(200)
    end

    let(:name) { nil }
    example_request "Fails to update a room_section" do
      expect(client.status).to eq(422)
    end
  end

  delete "/v1/room_sections/:id" do
    parameter :id, "RoomSection ID", required: true

    example_request "Destroys a room_section" do
      expect(client.status).to eq(204)
    end
  end
end