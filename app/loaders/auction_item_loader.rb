class AuctionItemLoader
  attr_reader :auction, :csv

  def initialize(auction, csv)
    @auction, @csv = auction, csv
  end

  def load!
    AuctionItem.transaction do
      CSV.parse(csv, headers: true).each do |row|
        donors = row["donor_names"].split(",").map do |donor_name|
          user = User.find_or_create_by!(name: donor_name)
          auction.donors.find_by(user_id: user.id) || auction.donors.create!(user: user)
        end
        bid_type = BidType.find_by!(name: row["bid_type_name"])
        bid_group = auction.bid_groups.find_by(name: row["bid_group_name"]) || auction.bid_groups.create!(name: row["bid_group_name"])
        donation_category = DonationCategory.find_by!(name: row["donation_category_name"])

        donation = auction.donations.find_by(title: row["donation_title"]) || auction.donations.new({
          title: row["donation_title"],
          description: row["donation_description"],
          estimated_value_amount: row["donation_estimated_value_amount"],
          donation_category: donation_category,
          quantity: row["donation_quantity"].present? ? row["donation_quantity"].gsub(/\D/,"").to_i : 1,
          notes: row["donation_notes"],
          donors: donors
        })

        donation.save!

        auction_item = auction.auction_items.find_by(donation_id: donation.id) || auction.auction_items.create!(
          donation: donation,
          bid_type: bid_type,
          bid_group: bid_group,
          minimum_bid_amount: row["minimum_bid_amount"].to_s.strip.present? ? row["minimum_bid_amount"].to_i : nil,
          number: row["auction_item_number"]
        )
      end
    end
  end
end
