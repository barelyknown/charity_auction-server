module V1
  RSpec.describe PaymentResource do

    let :creatable_fields do
      [
        :bidder,
        :amount,
        :payment_method,
        :auction
      ].sort
    end

    subject do
      described_class.new Payment.new, {}
    end

    it "has the correct creatable fields" do
      expect(described_class.creatable_fields({}).sort).to eq creatable_fields
    end

    it "has the correct updatable fields" do
      expect(described_class.updatable_fields({}).sort).to eq creatable_fields
    end

    it "has the correct fetchable fields" do
      expect(subject.fetchable_fields.sort).to eq (creatable_fields + [:id, :created_at, :updated_at, :unapplied_amount, :applied_amount]).sort
    end
  end
end
