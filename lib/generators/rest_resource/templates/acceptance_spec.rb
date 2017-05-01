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

  header "access-token", :auth_access_token
  header "token-type", :auth_token_type
  header "client", :auth_client
  header "expiry", :auth_expiry
  header "uid", :auth_uid

  let(<%= ":#{singular_table_name}" %>)    { build(<%= ":#{singular_table_name}" %>) }
  let(:id) { <%= "#{singular_table_name}.save and #{singular_table_name}.id" %> }

  get "/v1/<%= singular_table_name %>s" do
    example "Listing <%= singular_table_name %>s" do
      2.times { create(<%= ":#{singular_table_name}" %>) }
      do_request
      expect(client.status).to eq(200)
    end
  end

  get "/v1/<%= singular_table_name %>s/:id" do
    parameter :id, "<%= class_name %> ID", required: true

    example_request "Listing a <%= singular_table_name %>" do
      expect(client.status).to eq(200)
    end
  end

  post "/v1/<%= singular_table_name %>s" do
    with_options scope: <%= ":#{singular_table_name}" %> do
    <% attributes.each do |attribute| -%>
  parameter :<%= "#{attribute.name}, '#{attribute.name.titleize} of #{class_name}'" %>
    <% end -%>
end

    example "Creates a <%= singular_table_name %>" do
      expect {
        do_request({
          <%= "#{singular_table_name}: attributes_for(:#{singular_table_name})" %>
        })
      }.to change {
        <%= "#{class_name}.count" %>
      }.by 1
      expect(client.status).to eq(201)
    end

    let(:<%= attributes.first.name -%>) { nil }
    example_request "Fails to add a <%= singular_table_name %>" do
      do_request
      expect(client.status).to eq 422
    end
  end

  patch "/v1/<%= singular_table_name %>s/:id" do
    parameter :id, "<%= class_name %> ID", required: true

    with_options scope: <%= ":#{singular_table_name}" %> do
    <% attributes.each do |attribute| -%>
  parameter :<%= "#{attribute.name}, '#{attribute.name.titleize} of #{class_name}'" %>
    <% end -%>
end

    example "Updates a <%= singular_table_name %>" do
      do_request({
        <%= "#{singular_table_name}: {" %>
        <% attributes.each do |attribute| -%>
  <%= "#{attribute.name}: #{singular_table_name}.#{attribute.name}#{attribute == attributes.last ? nil : ','}" %>
        <% end -%>
}
      })
      expect(client.status).to eq(200)
    end

    let(:<%= attributes.first.name -%>) { nil }
    example_request "Fails to update a <%= singular_table_name %>" do
      expect(client.status).to eq(422)
    end
  end

  delete "/v1/<%= singular_table_name %>s/:id" do
    parameter :id, "<%= class_name %> ID", required: true

    example_request "Destroys a <%= singular_table_name %>" do
      expect(client.status).to eq(204)
    end
  end
end