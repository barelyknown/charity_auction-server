require "rspec_api_documentation_helper"

RSpec.resource "Bid Payments" do
  header "Content-Type", "application/vnd.api+json"

  let! :bid_model do
    FactoryGirl.create(:bid, winner: true)
  end

  let! :payment_model do
    FactoryGirl.create(:payment, auction: bid_model.auction_item.auction)
  end

  shared_context "parameters" do
    parameter "type", "The type of the resource. Always 'bid-payments'.", required: true

    let "type" do
      "bid-payments"
    end

    parameter "bid", <<-DESC, scope: :relationships, required: true
      The bid that the payment is being applied to.
    DESC

    parameter "payment", <<-DESC, scope: :relationships, required: true
      The payment that is being applied.
    DESC

    parameter "amount", <<-DESC, scope: :attributes, required: true
      The amount to apply.
    DESC
  end

  post "/v1/bid-payments" do
    include_context "parameters"

    let "bid" do
      {
        data: {
          id: bid_model.id.to_s,
          type: "bids"
        }
      }
    end

    let "payment" do
      {
        data: {
          id: payment_model.id.to_s,
          type: "payments"
        }
      }
    end

    let "amount" do
      payment_model.amount
    end

    example_request "POST /v1/payments" do
      expect(status).to eq 201
    end
  end
end
