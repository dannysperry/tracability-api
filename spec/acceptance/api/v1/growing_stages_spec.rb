# spec/acceptance/v1/growing_stage_spec.rb
require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "GrowingStages" do
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

  let(:growing_stage) { build(:growing_stage, license_id: license_id) }
  let(:id) { growing_stage.save and growing_stage.id }


  get "v1/licenses/:license_id/growing_stages" do
    parameter :license_id, 'License ID', required: true
    example "Listing growing_stages" do
      2.times { create(:growing_stage, license_id: license_id) }
      do_request
      expect(client.status).to eq(200)
    end
  end

  post "v1/licenses/:license_id/growing_stages" do
    parameter :license_id, 'License ID', required: true
    with_options scope: :growing_stage do
      parameter :name, 'Name of GrowingStage', required: true
      parameter :description, 'Description of GrowingStage'
    end

    example "Creates a growing_stage" do
      expect {
        do_request({
          license_id: license_id,
          growing_stage: attributes_for(:growing_stage)
        })
      }.to change {
        GrowingStage.count
      }.by 1
      expect(client.status).to eq(201)
    end

    let(:name) { nil }
    example_request "Fails to add a growing_stage" do
      expect(client.status).to eq 422
    end
  end

  get "/v1/growing_stages/:id" do
    parameter :id, "GrowingStage ID", required: true

    example_request "Listing a growing_stage" do
      expect(client.status).to eq(200)
    end
  end

  patch "/v1/growing_stages/:id" do
    parameter :id, "GrowingStage ID", required: true

    with_options scope: :growing_stage do
      parameter :name, 'Name of GrowingStage'
      parameter :description, 'Description of GrowingStage'
      parameter :license_id, 'License of GrowingStage'
    end

    example "Updates a growing_stage" do
      do_request({
        growing_stage: {
          name: growing_stage.name,
          description: growing_stage.description,
          license_id: growing_stage.license_id
        }
      })
      expect(client.status).to eq(200)
    end

    let(:name) { nil }
    example_request "Fails to update a growing_stage" do
      expect(client.status).to eq(422)
    end
  end

  delete "/v1/growing_stages/:id" do
    parameter :id, "GrowingStage ID", required: true

    example_request "Destroys a growing_stage" do
      expect(client.status).to eq(204)
    end
  end
end