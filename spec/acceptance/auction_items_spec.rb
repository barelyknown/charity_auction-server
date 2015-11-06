require "rspec_api_documentation_helper"

RSpec.resource "Auction Items" do
  header "Content-Type", "application/vnd.api+json"

  let! :auction_model do
    FactoryGirl.create(:auction)
  end

  let! :donation_model do
    FactoryGirl.create(:donation, auction: auction_model)
  end

  let! :bid_group_model do
    FactoryGirl.create(:bid_group, auction: auction_model)
  end

  shared_context "parameters" do
    parameter "type", "The type of the resource. Always 'auction-items'.", required: true

    let "type" do
      "auction-items"
    end

    parameter "auction", <<-DESC, scope: :relationships, required: true
      The auction to which the item belongs.
    DESC

    parameter "donation", <<-DESC, scope: :relationships, required: true
      The donation for the auction item.
    DESC

    parameter "bid-type", <<-DESC, scope: :relationships, required: true
      The bid type of the auction item.
    DESC

    parameter "bid-group", <<-DESC, scope: :relationships, required: true
      The bid group of the auction item.
    DESC

    parameter "minimum-bid-amount", <<-DESC, scope: :attributes
      The minimum amount of the bid. If the bid-type is 'fixed-price'
      then the minimum amount of the bid must be greater than 0.
    DESC
  end

  post "/v1/auction-items" do
    include_context "parameters"

    before do
      CharityAuctionServer::Application.load_tasks
      Rake::Task["seed:bid_types"].execute
    end

    let "auction" do
      {
        data: {
          id: auction_model.id.to_s,
          type: "auctions"
        }
      }
    end

    let "donation" do
      {
        data: {
          id: donation_model.id.to_s,
          type: "donations"
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

    let "bid-group" do
      {
        data: {
          id: bid_group_model.id.to_s,
          type: "bid-groups"
        }
      }
    end

    let "minimum-bid-amount" do
      10
    end

    example_request "POST /v1/auction-items" do
      expect(status).to eq 201
    end
  end
end
