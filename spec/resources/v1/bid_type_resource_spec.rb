module V1
  RSpec.describe BidTypeResource do

    subject do
      described_class.new BidType.new, {}
    end

    it "has no creatable fields" do
      expect(described_class.creatable_fields({})).to be_empty
    end

    it "has no updatable fields" do
      expect(described_class.updatable_fields({})).to be_empty
    end

    it "has the correct fetchable fields" do
      expect(subject.fetchable_fields.sort).to eq [:id, :created_at, :updated_at, :name].sort
    end
  end
end
