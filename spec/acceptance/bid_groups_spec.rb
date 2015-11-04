require "rspec_api_documentation_helper"

RSpec.resource "Bid Groups" do
  header "Content-Type", "application/vnd.api+json"

  let! :auction_model do
    FactoryGirl.create(:auction)
  end

  before do
    CharityAuctionServer::Application.load_tasks
    Rake::Task["seed:bid_types"].execute
  end

  shared_context "parameters" do
    parameter "type", "The type of the resource. Always 'bid-groups'.", required: true

    let "type" do
      "bid-groups"
    end

    parameter "auction", <<-DESC, scope: :relationships, required: true
      The auction for which the ticket is valid.
    DESC

    parameter "bid-type", <<-DESC, scope: :relationships, required: true
      The bid type of the bid group.
    DESC

    parameter "name", <<-DESC, scope: :attributes
      The name of the bid group.
    DESC

    parameter "description", <<-DESC, scope: :attributes
      The description of the bid group.
    DESC

    parameter "sequence-position", <<-DESC, scope: :attributes
      The sequence of the bid group within the auction.
      Based on the options allowed by the rank-model gem.
    DESC
  end

  post "/v1/bid-groups" do
    include_context "parameters"

    let "name" do
      "Bid Group 1"
    end

    let "description" do
      "Bid Group 1 description"
    end

    let "sequence-position" do
      "first"
    end

    let "auction" do
      {
        data: {
          id: auction_model.id.to_s,
          type: "auctions"
        }
      }
    end

    let "bid-type" do
      {
        data: {
          id: BidType.first.id.to_s,
          type: "bid-types"
        }
      }
    end

    example_request "POST /v1/bid-groups" do
      expect(status).to eq 201
    end
  end
end
