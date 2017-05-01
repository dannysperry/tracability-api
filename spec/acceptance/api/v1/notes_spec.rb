# spec/acceptance/v1/note_spec.rb
require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Notes" do
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

  let(:note)    { build(:note) }
  let(:id) { note.save and note.id }

  get "/v1/notes" do
    example "Listing notes" do
      2.times { create(:note) }
      do_request
      expect(client.status).to eq(200)
    end
  end

  get "/v1/notes/:id" do
    parameter :id, "Note ID", required: true

    example_request "Listing a note" do
      expect(client.status).to eq(200)
    end
  end

  post "/v1/notes" do
    with_options scope: :note do
      parameter :description, 'Description of Note'
      parameter :name, 'Name of Note', required: true
    end

    example "Creates a note" do
      expect {
        do_request({
          note: attributes_for(:note)
        })
      }.to change {
        Note.count
      }.by 1
      expect(client.status).to eq(201)
    end

    let(:name) { nil }
    example_request "Fails to add a note" do
      do_request
      expect(client.status).to eq 422
    end
  end

  patch "/v1/notes/:id" do
    parameter :id, "Note ID", required: true

    with_options scope: :note do
      parameter :description, 'Description of Note'
      parameter :name, 'Name of Note', required: true
    end

    example "Updates a note" do
      do_request({
        note: {
          description: note.description,
          name: note.name
        }
      })
      expect(client.status).to eq(200)
    end

    let(:name) { nil }
    example_request "Fails to update a note" do
      expect(client.status).to eq(422)
    end
  end

  delete "/v1/notes/:id" do
    parameter :id, "Note ID", required: true

    example_request "Destroys a note" do
      expect(client.status).to eq(204)
    end
  end
end