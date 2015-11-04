require "rspec_api_documentation_helper"

RSpec.resource "Tickets" do
  header "Content-Type", "application/vnd.api+json"

  let! :auction_model do
    FactoryGirl.create(:auction)
  end

  let! :user_model do
    FactoryGirl.create(:user)
  end

  shared_context "parameters" do
    parameter "type", "The type of the resource. Always 'tickets'.", required: true

    let "type" do
      "tickets"
    end

    parameter "number", <<-DESC, scope: :attributes
      The number of the ticket. Must be unique for the auction.
      Set automatically if omitted.
    DESC

    parameter "price", <<-DESC, scope: :attributes, required: true
      The price of the ticket.
    DESC

    parameter "auction", <<-DESC, scope: :relationships, required: true
      The auction for which the ticket is valid.
    DESC

    parameter "user", <<-DESC, scope: :relationships, required: true
      The user that owns the ticket.
    DESC
  end

  post "/v1/tickets" do
    include_context "parameters"

    let "number" do
      "2"
    end

    let "price" do
      "30"
    end

    let "auction" do
      {
        data: {
          id: auction_model.id.to_s,
          type: "auctions"
        }
      }
    end

    let "user" do
      {
        data: {
          id: user_model.id.to_s,
          type: "users"
        }
      }
    end

    example_request "POST /v1/tickets" do
      expect(status).to eq 201
    end
  end
end
