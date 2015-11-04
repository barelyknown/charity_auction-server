RSpec.describe BidGroup do
  it { is_expected.to belong_to :bid_type }

  it { is_expected.to belong_to :auction }

  it { is_expected.to validate_presence_of :bid_type }

  it { is_expected.to validate_presence_of :auction }

  it { is_expected.to have_attribute :name }

  it { is_expected.to have_attribute :description }

  it "enables bid groups to be ranked by sequence" do
    auction = FactoryGirl.create(:auction)
    subjects = 2.times.map do |n|
      FactoryGirl.create(:bid_group, auction: auction)
    end
    original_ids = subjects.map(&:id)
    subjects.each do |bid_group|
      bid_group.update! sequence_position: :first
    end
    expect(auction.bid_groups.rank(:sequence).pluck(:id)).to eq original_ids.reverse
  end
end
