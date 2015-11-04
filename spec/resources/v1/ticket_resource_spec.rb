module V1
  RSpec.describe TicketResource do

    let :creatable_fields do
      [
        :user,
        :auction,
        :price,
        :number
      ].sort
    end

    subject do
      described_class.new Ticket.new, {}
    end

    it "has the correct creatable fields" do
      expect(described_class.creatable_fields({}).sort).to eq creatable_fields
    end

    it "has the correct updatable fields" do
      expect(described_class.updatable_fields({}).sort).to eq creatable_fields
    end

    it "has the correct fetchable fields" do
      expect(subject.fetchable_fields.sort).to eq (creatable_fields + [:id, :created_at, :updated_at, :bidders]).sort
    end
  end
end
