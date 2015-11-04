require "rspec_api_documentation_helper"

RSpec.resource "Bidders" do
  header "Content-Type", "application/vnd.api+json"

  let! :auction_model do
    FactoryGirl.create(:auction)
  end

  let! :ticket_model do
    FactoryGirl.create(:ticket, auction: auction_model)
  end

  shared_context "parameters" do
    parameter "type", "The type of the resource. Always 'bidders'.", required: true

    let "type" do
      "bidders"
    end

    parameter "auction", <<-DESC, scope: :relationships, required: true
      The auction for which the bidder is valid.
    DESC

    parameter "tickets", <<-DESC, scope: :relationships, required: true
      The tickets for the bidder.
    DESC
  end

  post "/v1/bidders" do
    include_context "parameters"

    let "auction" do
      {
        data: {
          id: auction_model.id.to_s,
          type: "auctions"
        }
      }
    end

    let "tickets" do
      {
        data: [
          {
            id: ticket_model.id.to_s,
            type: "tickets"
          }
        ]
      }
    end

    example_request "POST /v1/bidders" do
      expect(status).to eq 201
    end
  end
end
