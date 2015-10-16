RSpec.describe Membership do
  it { is_expected.to belong_to :user }

  it { is_expected.to belong_to :organization }

  it { is_expected.to validate_presence_of :user }

  it { is_expected.to validate_presence_of :organization }

  it "validates that the user has not changed" do
    subject = FactoryGirl.create(:membership)
    subject.user = User.new
    subject.valid?
    expect(subject.errors[:user]).to include "cannot be changed"
  end

  it "validates that the user has not changed" do
    subject = FactoryGirl.create(:membership)
    subject.organization = Organization.new
    subject.valid?
    expect(subject.errors[:organization]).to include "cannot be changed"
  end
end
