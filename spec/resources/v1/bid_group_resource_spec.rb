module V1
  RSpec.describe BidGroupResource do

    let :creatable_fields do
      [
        :auction,
        :bid_type,
        :name,
        :description,
        :sequence_position,
        :sequence
      ].sort
    end

    subject do
      described_class.new BidGroup.new, {}
    end

    it "has the correct creatable fields" do
      expect(described_class.creatable_fields({}).sort).to eq creatable_fields
    end

    it "has the correct updatable fields" do
      expect(described_class.updatable_fields({}).sort).to eq creatable_fields
    end

    it "has the correct fetchable fields" do
      expect(subject.fetchable_fields.sort).to eq (creatable_fields + [:id, :created_at, :updated_at, :donations]).sort
    end
  end
end
