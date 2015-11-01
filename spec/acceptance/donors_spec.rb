require "rspec_api_documentation_helper"

RSpec.resource "Donors" do
  header "Content-Type", "application/vnd.api+json"

  shared_context "donor parameters" do
    parameter "type", <<-DESC, required: true
      The type of the resource. Must be donors.
    DESC

    let "type" do
      "donors"
    end

    parameter "user", <<-DESC, scope: :relationships, required: true
      The user that is the donor.
    DESC

    parameter "auction", <<-DESC, scope: :relationships, required: true
      The auction for which the user is a donor.
    DESC
  end

  post "/v1/donors" do
    include_context "donor parameters"

    let! :user_model do
      FactoryGirl.create(:user)
    end

    let! :auction_model do
      FactoryGirl.create(:auction)
    end

    let "user" do
      {
        data: {
          id: user_model.id.to_s,
          type: "users"
        }
      }
    end

    let "auction" do
      {
        data: {
          id: auction_model.id.to_s,
          type: "auctions"
        }
      }
    end

    example_request "POST /v1/donors" do
      expect(status).to eq 201
    end
  end
end
