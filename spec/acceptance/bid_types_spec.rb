require "rake"
require "rspec_api_documentation_helper"

RSpec.resource "Bid Types" do
  header "Content-Type", "application/vnd.api+json"

  before do
    CharityAuctionServer::Application.load_tasks
    Rake::Task["seed:bid_types"].execute
  end

  get "/v1/bid-types" do
    example_request "GET /v1/bid-types" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"].size).to eq BidType.count
    end
  end

  get "/v1/bid-types/:bid_type_id" do
    let :bid_type_id do
      BidType.first.id.to_s
    end

    example_request "GET /v1/bid-types/:id" do
      expect(status).to eq 200
    end
  end
end
