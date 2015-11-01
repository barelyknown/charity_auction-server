module V1
  RSpec.describe DonationDonorResource do
    let :creatable_fields do
      [:donor, :donation]
    end

    subject do
      described_class.new DonationDonor.new, {}
    end

    it "has the correct creatable fields" do
      expect(described_class.creatable_fields({}).sort).to eq creatable_fields.sort
    end

    it "has the correct updatable fields" do
      expect(described_class.updatable_fields({}).sort).to eq creatable_fields.sort
    end

    it "has the correct fetchable fields" do
      expect(subject.fetchable_fields.sort).to eq (creatable_fields + [:id, :created_at, :updated_at]).sort
    end
  end
end
