require "rspec_api_documentation_helper"

RSpec.resource "Donation Donors" do
  header "Content-Type", "application/vnd.api+json"

  post "/v1/donation-donors" do
    let! :auction_model do
      FactoryGirl.create(:auction)
    end

    let! :donor_model do
      FactoryGirl.create(:donor, auction: auction_model)
    end

    let! :donation_model do
      FactoryGirl.create(:donation, auction: auction_model)
    end

    parameter "type", <<-DESC, required: true
      The type of the resource. Always 'donation-donors'.
    DESC

    let "type" do
      "donation-donors"
    end

    parameter "donor", <<-DESC, required: true, scope: :relationships
      The donor.
    DESC

    let "donor" do
      {
        data: {
          type: "donors",
          id: donor_model.id.to_s
        }
      }
    end

    parameter "donation", <<-DESC, required: true, scope: :relationships
      The donation.
    DESC

    let "donation" do
      {
        data: {
          type: "donations",
          id: donation_model.id.to_s
        }
      }
    end

    example_request "POST /v1/donation-donor" do
      expect(status).to eq 201
    end
  end
end
