require "rspec_api_documentation_helper"

RSpec.resource "Organizations" do
  header "Content-Type", "application/vnd.api+json"

  shared_context "organization parameters" do
    parameter "type", <<-DESC, required: true
      The type of the resource. Always 'organizations'.
    DESC

    let "type" do
      "organizations"
    end

    parameter "name", <<-DESC, required: true, scope: :attributes
      The name of the organization.
    DESC
  end

  shared_context "with a persisted organization" do
    let! :persisted_organization do
      FactoryGirl.create(:organization)
    end

    let "organization_id" do
      persisted_organization.id.to_s
    end
  end

  post "/v1/organizations" do
    include_context "organization parameters"
    let "name" do
      "1st Street Elementary School"
    end

    example_request "POST /v1/organizations" do
      expect(status).to eq 201
    end
  end

  get "/v1/organizations/:organization_id" do
    include_context "with a persisted organization"
    example_request "GET /v1/organizations/:id" do
      expect(status).to eq 200
    end
  end

  patch "/v1/organizations/:organization_id" do
    include_context "organization parameters"

    include_context "with a persisted organization"

    parameter "id", <<-DESC, required: true
      The id of the organization.
    DESC

    let :id do
      persisted_organization.id.to_s
    end

    let "name" do
      "2nd Street High School"
    end

    example_request "PATCH /v1/organizations/:id" do
      expect(status).to eq 200
      organization = JSON.parse(response_body)
      expect(organization["data"]["attributes"]["name"]).to eq public_send("name")
    end
  end

  get "/v1/organizations" do
    before do
      2.times do
        FactoryGirl.create(:organization)
      end
    end
    example_request "GET /v1/organizations" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"].size).to eq 2
    end
  end

  delete "/v1/organizations/:organization_id" do
    include_context "with a persisted organization"
    example_request "DELETE /v1/organizations/:id" do
      expect(status).to eq 204
    end
  end

end
