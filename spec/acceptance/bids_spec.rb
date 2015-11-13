require "rspec_api_documentation_helper"

RSpec.resource "Bids" do
  header "Content-Type", "application/vnd.api+json"

  let! :auction_model do
    FactoryGirl.create(:auction)
  end

  let! :auction_item_model do
    FactoryGirl.create(:auction_item, auction: auction_model)
  end

  let! :bidder_model do
    FactoryGirl.create(:bidder, auction: auction_model)
  end

  shared_context "parameters" do
    parameter "type", "The type of the resource. Always 'bids'.", required: true

    let "type" do
      "bids"
    end

    parameter "auction-item", <<-DESC, scope: :relationships, required: true
      The auction-item to which the item belongs.
    DESC

    parameter "bidder", <<-DESC, scope: :relationships, required: true
      The bidder for the auction item.
    DESC

    parameter "amount", <<-DESC, scope: :attributes, required: true
      The amount of the bid.
    DESC

    parameter "winner", <<-DESC, scope: :attributes, required: true
      Whether or not the bid is a winner.
    DESC
  end

  post "/v1/bids" do
    include_context "parameters"

    let "auction-item" do
      {
        data: {
          id: auction_item_model.id.to_s,
          type: "auction-items"
        }
      }
    end

    let "bidder" do
      {
        data: {
          id: bidder_model.id.to_s,
          type: "bidders"
        }
      }
    end

    let "amount" do
      10
    end

    let "winner" do
      true
    end

    example_request "POST /v1/bids" do
      expect(status).to eq 201
    end
  end
end
