require "rspec_api_documentation_helper"

RSpec.resource "Payments" do
  header "Content-Type", "application/vnd.api+json"

  let! :auction_model do
    FactoryGirl.create(:auction)
  end

  let! :bidder_model do
    FactoryGirl.create(:bidder, auction: auction_model)
  end

  shared_context "parameters" do
    parameter "type", "The type of the resource. Always 'payments'.", required: true

    let "type" do
      "payments"
    end

    parameter "bidder", <<-DESC, scope: :relationships
      The bidder (if a specific one) that's making the payment.
    DESC

    parameter "auction", <<-DESC, scope: :relationships, required: true
      The bidder (if a specific one) that's making the payment.
    DESC

    parameter "amount", <<-DESC, scope: :attributes, required: true
      The amount of the payment.
    DESC

    parameter "payment-method", <<-DESC, scope: :attributes, required: true
      The method of the payment. cash, check, credit_card
    DESC
  end

  post "/v1/payments" do
    include_context "parameters"

    let "auction" do
      {
        data: {
          id: auction_model.id.to_s,
          type: "auctions"
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
      1000
    end

    let "payment-method" do
      "credit_card"
    end

    example_request "POST /v1/payments" do
      expect(status).to eq 201
    end
  end
end
