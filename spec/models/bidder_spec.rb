RSpec.describe Bidder do
  it { is_expected.to belong_to :auction }

  it { is_expected.to validate_presence_of :auction }

  it { is_expected.to have_many :bidder_tickets }

  it { is_expected.to have_many(:tickets).through(:bidder_tickets) }

  it "validates that tickets aren't empty" do
    subject.tickets = []
    subject.valid?
    expect(subject.errors[:tickets]).to include "must not be empty"
  end

  it "has a valid factory" do
    expect{FactoryGirl.create(:bidder)}.not_to raise_error
  end
end
