RSpec.describe DonationDonor do
  it { is_expected.to belong_to :donation }

  it { is_expected.to belong_to :donor }

  it { is_expected.to validate_presence_of :donation }

  it { is_expected.to validate_presence_of :donor }
end
