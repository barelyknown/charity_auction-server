module V1
  RSpec.describe DonationResource do

    let :creatable_fields do
      [
        :title,
        :description,
        :quantity,
        :redemption_window_starts_at,
        :redemption_window_ends_at,
        :estimated_value_amount,
        :minimum_bid_amount,
        :display_description,
        :fulfillment_type,
        :bid_type,
        :donation_category,
        :auction,
        :notes,
        :bid_group
      ].sort
    end

    subject do
      described_class.new Donation.new, {}
    end

    it "has the correct creatable fields" do
      expect(described_class.creatable_fields({}).sort).to eq creatable_fields
    end

    it "has the correct updatable fields" do
      expect(described_class.updatable_fields({}).sort).to eq creatable_fields
    end

    it "has the correct fetchable fields" do
      expect(subject.fetchable_fields.sort).to eq (creatable_fields + [:id, :created_at, :updated_at, :donation_donors]).sort
    end
  end
end
