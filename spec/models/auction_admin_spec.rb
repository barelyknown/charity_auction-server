RSpec.describe AuctionAdmin do
  it { is_expected.to belong_to :auction }

  it { is_expected.to belong_to :user }

  it { is_expected.to validate_presence_of :auction }

  it { is_expected.to validate_presence_of :user }

  it "validates the uniqueness of user_id scoped to auction_id" do
    original = FactoryGirl.create(:auction_admin)
    duplicate = FactoryGirl.build(:auction_admin, user: original.user, auction: original.auction)
    duplicate.valid?
    expect(duplicate.errors[:user_id]).to include "has already been taken"
  end
end
