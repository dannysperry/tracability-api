# spec/acceptance/v1/regulation_spec.rb
require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Regulations" do
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

  let(:regulation) { build(:regulation) }
  let(:id) { regulation.save and regulation.id }


  get "/v1/regulations" do
    example "Listing regulations" do
      2.times { create(:regulation) }
      do_request
      expect(client.status).to eq(200)
    end
  end

  post "/v1/regulations" do
    with_options scope: :regulation do
      parameter :legal_reference_code, 'Legal Reference Code of Regulation', required: true
    end

    example "Creates a regulation" do
      expect {
        do_request({
          regulation: attributes_for(:regulation)
        })
      }.to change {
        Regulation.count
      }.by 1
      expect(client.status).to eq(201)
    end

    let(:legal_reference_code) { nil }
    example_request "Fails to add a regulation" do
      expect(client.status).to eq 422
    end
  end

  get "/v1/regulations/:id" do
    parameter :id, "Regulation ID", required: true

    example_request "Listing a regulation" do
      expect(client.status).to eq(200)
    end
  end

  patch "/v1/regulations/:id" do
    parameter :id, "Regulation ID", required: true

    with_options scope: :regulation do
      parameter :legal_reference_code, 'Legal Reference Code of Regulation'
    end

    example "Updates a regulation" do
      do_request({
        regulation: {
          legal_reference_code: regulation.legal_reference_code
        }
      })
      expect(client.status).to eq(200)
    end

    let(:legal_reference_code) { nil }
    example_request "Fails to update a regulation" do
      expect(client.status).to eq(422)
    end
  end

  delete "/v1/regulations/:id" do
    parameter :id, "Regulation ID", required: true

    example_request "Destroys a regulation" do
      expect(client.status).to eq(204)
    end
  end
end