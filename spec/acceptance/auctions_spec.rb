require "rspec_api_documentation_helper"

RSpec.resource "Auctions" do
  header "Content-Type", "application/vnd.api+json"

  shared_context "auction parameters" do
    parameter "type", <<-DESC, required: true
      The type of the resource. Always 'auctions'.
    DESC

    let "type" do
      "auctions"
    end

    parameter "organization", <<-DESC, scope: :relationships, required: true
      The organization to which the auction belongs.
    DESC

    parameter "name", <<-DESC, scope: :attributes
      The name by which the auction should be referred to.
    DESC

    parameter "donation-window-ends-at", <<-DESC, scope: :attributes
      The time in UTC after which donations to the auction can no longer be accepted.
    DESC

    parameter "starts-at", <<-DESC, scope: :attributes
      The time in UTC at which the auction begins.
    DESC

    parameter "ends-at", <<-DESC, scope: :attributes
      The time in UTC at which the auction ends.
    DESC

    parameter "time-zone-id", <<-DESC, scope: :attributes
      The time zone id that should be used to localize the times for the auction. For example, 'America/New_York'.
    DESC

    parameter "physical-address", <<-DESC, scope: :attributes
      The physical address at which the auction will be held.
    DESC
  end

  shared_context "persisted auction" do
    let! :persisted_auction do
      FactoryGirl.create(:auction)
    end

    let :auction_id do
      persisted_auction.id.to_s
    end
  end

  post "/v1/auctions" do
    include_context "auction parameters"

    let! :persisted_organization do
      FactoryGirl.create(:organization)
    end

    let "name" do
      "Octoberfest 2015 Charity Auction"
    end

    let "donation-window-ends-at" do
      Time.utc(2015,10,16,11,0).as_json
    end

    let "starts-at" do
      Time.utc(2015,10,17,11,0).as_json
    end

    let "ends-at" do
      Time.utc(2015,10,17,13,0).as_json
    end

    let "time-zone-id" do
      "America/New_York"
    end

    let "physical-address" do
      "321 Broadway\nNew York, NY 12345"
    end

    let "organization" do
      {
        data: {
          type: "organizations",
          id: persisted_organization.id.to_s
        }
      }
    end

    example_request "POST /v1/auctions" do
      expect(status).to eq 201
      auction = JSON.parse(response_body)
      expect(auction["data"]["attributes"]["starts-at"]).to eq public_send("starts-at")
    end
  end

  patch "/v1/auctions/:auction_id" do
    include_context "auction parameters"

    let! :persisted_auction do
      FactoryGirl.create(:auction)
    end

    let :auction_id do
      persisted_auction.id.to_s
    end

    parameter "id", "The id of the resource", required: true

    let "id" do
      persisted_auction.id.to_s
    end

    let "name" do
      "Scary Fundraiser"
    end

    example_request "PATCH /v1/auctions/:id" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"]["attributes"]["name"]).to eq public_send("name")
    end
  end

  get "/v1/auctions" do
    before do
      FactoryGirl.create(:auction)
    end

    example_request "GET /v1/auctions" do
      expect(status).to eq 200
    end
  end

  get "/v1/auctions/:auction_id" do
    include_context "persisted auction"
    example_request "GET /v1/auctions/:id" do
      expect(status).to eq 200
    end
  end

  delete "/v1/auctions/:auction_id" do
    include_context "persisted auction"
    example_request "DELETE /v1/auctions/:id" do
      expect(status).to eq 204
    end
  end

end
