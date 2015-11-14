module V1
  RSpec.describe BidderResource do

    subject do
      described_class.new Bidder.new, {}
    end

    let :creatable_fields do
      [:auction, :tickets, :number]
    end

    it "has the correct creatable fields" do
      expect(described_class.creatable_fields({}).sort).to eq creatable_fields.sort
    end

    it "has the correct updatable fields" do
      expect(described_class.creatable_fields({}).sort).to eq creatable_fields.sort
    end

    it "has the correct fetchable fields" do
      expect(subject.fetchable_fields.sort).to eq [:id, :created_at, :updated_at, :auction, :tickets, :payments, :bids, :number].sort
    end
  end
end
