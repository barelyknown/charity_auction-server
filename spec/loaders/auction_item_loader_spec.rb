RSpec.describe AuctionItemLoader do

  let! :auction do
    FactoryGirl.create(:auction)
  end

  let :csv do
    <<-ROWS.strip_heredoc
      donor_names,donation_title,donation_description,donation_estimated_value_amount,donation_category_name,bid_type_name,bid_group_name,donation_notes,donation_quantity,minimum_bid_amount,auction_item_number
      "Sean Devine,Theresa Devine","Night out","...on the town",1000,Food/Drink,silent,Silent - Early,"much work to do!",1,30,1
    ROWS
  end

  before do
    CharityAuctionServer::Application.load_tasks
    Rake::Task["seed:bid_types"].execute
    Rake::Task["seed:donation_categories"].execute
  end

  it "loads them correctly" do
    subject = described_class.new auction, csv
    subject.load!
    subject.load!
    auction.reload
    expect(User.count).to eq 2
    expect(auction.donors.count).to eq 2
    expect(auction.bid_groups.count).to eq 1
    expect(auction.donations.count).to eq 1
    expect(auction.donations.first.donors.count).to eq 2
    expect(auction.auction_items.count).to eq 1
    auction_item = auction.auction_items.last
    expect(auction_item.number).to eq "1"
  end
end
