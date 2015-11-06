RSpec.describe BidderLoader do

  let! :auction do
    FactoryGirl.create(:auction)
  end

  let :csv do
    <<-ROWS.strip_heredoc
      ticket_number,bidder_number,user_name,user_physical_address,user_mobile_phone,user_email
      1,1,John Doe,,,
      2,1,Jane Doe,,,
      3,2,Michael Strahan,,,
    ROWS
  end

  it "can load the bidders" do
    subject = described_class.new(auction, csv)
    subject.load!
    subject.load!
    auction.reload
    expect(User.count).to eq 3
    expect(auction.tickets.count).to eq 3
    expect(auction.bidders.count).to eq 2
  end

end
