module V1
  RSpec.describe DonationCategoryResource do

    subject do
      described_class.new DonationCategory.new, {}
    end

    it "has no creatable fields" do
      expect(described_class.creatable_fields({})).to eq [:name]
    end

    it "has no updatable fields" do
      expect(described_class.updatable_fields({})).to eq [:name]
    end

    it "has the correct fetchable fields" do
      expect(subject.fetchable_fields.sort).to eq [:id, :created_at, :updated_at, :name].sort
    end
  end
end
