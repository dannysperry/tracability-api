# spec/acceptance/v1/<%= singular_table_name %>_spec.rb
require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "<%= class_name %>s" do
  let(:user) { create(:user) }
  let(:auth_tokens) { user.confirm && user.create_new_auth_token }

  let(:auth_access_token) { auth_tokens['access-token'] }
  let(:auth_token_type)   { auth_tokens['token-type'] }
  let(:auth_client)       { auth_tokens['client'] }
  let(:auth_expiry)       { auth_tokens['expiry'] }
  let(:auth_uid)          { auth_tokens['uid'] }

  header "Accept", "application/json"
  header "access-token", :auth_access_token
  header "token-type", :auth_token_type
  header "client", :auth_client
  header "expiry", :auth_expiry
  header "uid", :auth_uid

  let(<%= ":#{singular_table_name}" %>)    { create(<%= ":#{singular_table_name}" %>) }
  let(<%= ":#{singular_table_name}_id" %>) { <%= "#{singular_table_name}.id" %> }

  # A specific endpoint
  get "/v1/<%= singular_table_name %>s" do
    example "Listing <%= singular_table_name %>s" do
      explanation "Retrieve all of the <%= singular_table_name %>s."

      2.times { create(<%= ":#{singular_table_name}" %>) }

      do_request

      expect(client.status).to eq(200)
    end
  end

  get "/v1/<%= singular_table_name %>s/:id" do
    parameter :id, "<%= class_name %> ID", required: true

    example "Listing Single <%= singular_table_name %>" do
      explanation "Retreive a single <%= singular_table_name %> by it's :id"

      do_request({
        id: <%= "#{singular_table_name}_id" %>
      })

      expect(client.status).to eq(200)
    end
  end

  post "/v1/<%= singular_table_name %>s" do

    with_options scope: <%= ":#{singular_table_name}" %> do
    <% attributes.each do |attribute| -%>
  parameter :<%= "#{attribute.name}" %>, "attribute_description"
    <% end -%>
end

    example "sucessfully adds a <%= singular_table_name %>" do
      expect {
        do_request({
          <%= "#{singular_table_name}: attributes_for(:#{singular_table_name})" -%>
        })
      }.to change {
        <%= "#{class_name}.count" %>
      }.by 1
      # test for the 200 status-code
      expect(client.status).to eq(201)
    end
    example "fails to add a <%= singular_table_name %>" do
      do_request({
        <%= "#{singular_table_name}: attributes_for(:#{singular_table_name}, #{attributes.first.name}: nil)" -%>
      })
      expect(client.status).to eq 422
    end
  end

  patch "/v1/<%= singular_table_name %>s/:id" do
    parameter :id, "<%= class_name %> ID", required: true

    with_options scope: <%= ":#{singular_table_name}" %> do
    <% attributes.each do |attribute| -%>
  parameter :<%= "#{attribute.name}" %>, "attribute_description"
    <% end -%>
end


    example "successfully updates the <%= singular_table_name %>" do
      do_request({
        id: <%= "#{singular_table_name}_id" %>,
        <%= "#{singular_table_name}: attributes_for(:#{singular_table_name})" -%>
      })
      expect(client.status).to eq(200)
    end

    example "fails to update the <%= singular_table_name %>" do
      do_request({
        id: <%= "#{singular_table_name}_id" %>,
        <%= "#{singular_table_name}: attributes_for(:#{singular_table_name}, #{attributes.first.name}: nil)" -%>
      })
      expect(client.status).to eq(422)
    end
  end

  delete "/v1/<%= singular_table_name %>s/:id" do
    parameter :id, "<%= class_name %> ID", required: true

    example "removed a <%= singular_table_name %>" do
      do_request({
        id: <%= "#{singular_table_name}_id" %>
      })
      expect(client.status).to eq(204)
    end
  end
end