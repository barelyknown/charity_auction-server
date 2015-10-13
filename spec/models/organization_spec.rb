RSpec.describe Organization do
  it { is_expected.to have_attribute :name }

  it { is_expected.to validate_presence_of :name }

  it { is_expected.to have_many :auctions }

  it { is_expected.to have_many :memberships }
end
