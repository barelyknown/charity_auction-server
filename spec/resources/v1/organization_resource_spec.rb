module V1
  RSpec.describe OrganizationResource do
    let :creatable_fields do
      [:name]
    end

    subject do
      described_class.new Organization.new, {}
    end

    it "has the correct creatable fields" do
      expect(described_class.creatable_fields({}).sort).to eq creatable_fields.sort
    end

    it "has the correct updatable fields" do
      expect(described_class.updatable_fields({}).sort).to eq creatable_fields.sort
    end

    it "has the correct fetchable fields" do
      expect(subject.fetchable_fields.sort).to eq (creatable_fields + [:id, :created_at, :updated_at, :memberships, :auctions]).sort
    end
  end
end
