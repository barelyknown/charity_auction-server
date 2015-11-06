require "rspec_api_documentation_helper"

RSpec.resource "Donations" do
  header "Content-Type", "application/vnd.api+json"

  shared_context "donation parameters" do
    parameter "type", "The type of the resource. Always 'donations'.", required: true

    let "type" do
      "donations"
    end

    parameter "title", <<-DESC, scope: :attributes
      The title of the donation.
    DESC

    parameter "description", <<-DESC, scope: :attributes
      The description of the donation.
    DESC

    parameter "display-description", <<-DESC, scope: :attributes
      The description of what will be displayed for the item.
    DESC

    parameter "quantity", <<-DESC, scope: :attributes
      The number of units of the described item included in the donation.
    DESC

    parameter "redemption-window-starts-at", <<-DESC, scope: :attributes
      The earliest time in UTC at which the donation may be redeemed.
    DESC

    parameter "redemption-window-ends-at", <<-DESC, scope: :attributes
      The latest time in UTC at which the donation may be redeemed.
    DESC

    parameter "estimated-value-amount", <<-DESC, scope: :attributes
      The estimated value per unit of the donated item.
    DESC

    parameter "fulfillment-type", <<-DESC, scope: :attributes
      The way in which the item will be fulfilled. Valid values are 'item' and 'certificate'.
    DESC

    parameter "notes", <<-DESC, scope: :attributes
      Notes about the auction managed by and visible to the administrators of the auction.
    DESC

    parameter "donation-category", <<-DESC, scope: :relationships
      The type of the donation category.
    DESC

    parameter "auction", <<-DESC, scope: :relationships
      The auction to which this donation is made.
    DESC
  end

  post "/v1/donations" do
    include_context "donation parameters"

    before do
      CharityAuctionServer::Application.load_tasks
      Rake::Task["seed:bid_types"].execute
      Rake::Task["seed:donation_categories"].execute
    end

    let "title" do
      "Weekend at fancy ski house"
    end

    let "description" do
      "Way at the top of the mountain. Take the chair lift, hang a right."
    end

    let "display-description" do
      "Pictures of our fancy trip last Christmas."
    end

    let "quantity" do
      1
    end

    let "redemption-window-starts-at" do
      Time.utc(2016,1,1,0,0).as_json
    end

    let "redemption-window-ends-at" do
      Time.utc(2016,2,1,0,0).as_json
    end

    let "estimated-value-amount" do
      10_000
    end

    let "fulfillment-type" do
      "certificate"
    end

    let "notes" do
      "This should be a big one!"
    end

    let "donation-category" do
      {
        data: {
          id: DonationCategory.first.id.to_s,
          type: "donation-categories"
        }
      }
    end

    let! :persisted_auction do
      FactoryGirl.create(:auction)
    end

    let "auction" do
      {
        data: {
          id: persisted_auction.id.to_s,
          type: "auctions"
        }
      }
    end

    example_request "POST /v1/donations" do
      expect(status).to eq 201
    end
  end

  shared_context "persisted donation" do
    let! :persisted_donation do
      FactoryGirl.create(:donation)
    end

    let :donation_id do
      persisted_donation.id.to_s
    end
  end

  patch "/v1/donations/:donation_id" do
    include_context "donation parameters"
    include_context "persisted donation"

    parameter "id", "The id of the resource", required: true

    let "id" do
      persisted_donation.id.to_s
    end

    let "title" do
      "LOOK OVER HERE! Free spectacles."
    end

    example_request "POST /v1/donations/:id" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"]["attributes"]["title"]).to eq title
    end
  end

  get "/v1/donations/:donation_id" do
    include_context "persisted donation"
    example_request "GET /v1/donations/:id" do
      expect(status).to eq 200
    end
  end

  get "/v1/donations" do
    include_context "persisted donation"
    example_request "GET /v1/donations" do
      expect(status).to eq 200
    end
  end

  delete "/v1/donations/:donation_id" do
    include_context "persisted donation"
    example_request "DELETE /v1/donations/:id" do
      expect(status).to eq 204
    end
  end
end
