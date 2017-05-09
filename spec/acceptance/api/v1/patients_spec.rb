# spec/acceptance/v1/patient_spec.rb
require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Patients" do
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

  let(:physician) { build(:physician) }
  let(:physician_id) { physician.save and physician.id }

  let(:patient) { build(:patient, physician_id: physician_id) }
  let(:id) { patient.save and patient.id }


  get "v1/physicians/:physician_id/patients" do
    parameter :physician_id, 'Physician ID', required: true
    example "Listing patients" do
      2.times { create(:patient, physician_id: physician_id) }
      do_request
      expect(client.status).to eq(200)
    end
  end

  post "v1/physicians/:physician_id/patients" do
    parameter :physician_id, 'Physician ID', required: true
    with_options scope: :patient, required: true do
      parameter :name, 'Name of Patient'
      parameter :street_address, 'Street Address of Patient'
      parameter :is_medical, 'Is Medical of Patient'
      parameter :city_id, 'City of Patient'
    end

    example "Creates a patient" do
      expect {
        physician_id
        do_request({
          physician_id: physician_id,
          patient: patient.attributes
        })
      }.to change {
        Patient.count
      }.by 1
      expect(client.status).to eq(201)
    end

    let(:name) { nil }
    example_request "Fails to add a patient" do
      expect(client.status).to eq 422
    end
  end

  get "/v1/patients/:id" do
    parameter :id, "Patient ID", required: true

    example_request "Listing a patient" do
      expect(client.status).to eq(200)
    end
  end

  patch "/v1/patients/:id" do
    parameter :id, "Patient ID", required: true

    with_options scope: :patient do
      parameter :physician_id, 'Physician of Patient'
      parameter :name, 'Name of Patient'
      parameter :street_address, 'Street Address of Patient'
      parameter :is_medical, 'Is Medical of Patient'
      parameter :city_id, 'City of Patient'
    end

    example "Updates a patient" do
      do_request({
        patient: {
          physician_id: patient.physician_id,
          name: patient.name,
          street_address: patient.street_address,
          is_medical: patient.is_medical,
          city_id: patient.city_id
        }
      })
      expect(client.status).to eq(200)
    end

    let(:name) { nil }
    example_request "Fails to update a patient" do
      expect(client.status).to eq(422)
    end
  end

  delete "/v1/patients/:id" do
    parameter :id, "Patient ID", required: true

    example_request "Destroys a patient" do
      expect(client.status).to eq(204)
    end
  end
end