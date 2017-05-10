# spec/acceptance/v1/growing_medium_spec.rb
require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "GrowingMediums" do
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

  let(:room_section) { build(:room_section) }
  let(:room_section_id) { room_section.save and room_section.id }

  let(:growing_medium) { build(:growing_medium, room_section_id: room_section_id) }
  let(:id) { growing_medium.save and growing_medium.id }


  get "v1/room_sections/:room_section_id/growing_media" do
    parameter :room_section_id, 'RoomSection ID', required: true
    example "Listing growing_media" do
      2.times { create(:growing_medium, room_section_id: room_section_id) }
      do_request
      expect(client.status).to eq(200)
    end
  end

  post "v1/room_sections/:room_section_id/growing_media" do
    parameter :room_section_id, 'RoomSection ID', required: true
    with_options scope: :growing_medium, required: true do
      parameter :medium_type, 'Medium Type of GrowingMedium'
      parameter :name, 'Name of GrowingMedium'
      parameter :barcode, 'Barcode of GrowingMedium'
      parameter :quantity, 'Quantity of specific of GrowingMedium item'
    end

    example "Creates a growing_medium" do
      room_section_id
      expect {
        do_request({
          room_section_id: room_section_id,
          growing_medium: attributes_for(:growing_medium)
        })
      }.to change {
        GrowingMedium.count
      }.by 1
      expect(client.status).to eq(201)
    end

    let(:name) { nil }
    example_request "Fails to add a growing_medium" do
      expect(client.status).to eq 422
    end
  end

  get "/v1/growing_media/:id" do
    parameter :id, "GrowingMedium ID", required: true

    example_request "Listing a growing_medium" do
      expect(client.status).to eq(200)
    end
  end

  patch "/v1/growing_media/:id" do
    parameter :id, "GrowingMedium ID", required: true

    with_options scope: :growing_medium do
      parameter :room_section_id, 'Room Section of GrowingMedium'
      parameter :medium_type, 'Medium Type of GrowingMedium'
      parameter :name, 'Name of GrowingMedium'
      parameter :barcode, 'Barcode of GrowingMedium'
      parameter :quantity, 'Quantity of specific of GrowingMedium item'
    end

    example "Updates a growing_medium" do
      do_request({
        growing_medium: {
          room_section_id: growing_medium.room_section_id,
          medium_type: growing_medium.medium_type,
          name: growing_medium.name,
          barcode: growing_medium.barcode,
          quantity: growing_medium.quantity
        }
      })
      expect(client.status).to eq(200)
    end

    let(:name) { nil }
    example_request "Fails to update a growing_medium" do
      expect(client.status).to eq(422)
    end
  end

  delete "/v1/growing_media/:id" do
    parameter :id, "GrowingMedium ID", required: true

    example_request "Destroys a growing_medium" do
      expect(client.status).to eq(204)
    end
  end
end