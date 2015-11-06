class BidderLoader

  attr_reader :auction, :csv

  def initialize(auction, csv)
    @auction, @csv = auction, csv
  end

  def load!
    CSV.parse(csv, headers: true).each do |row|
      user = User.find_or_create_by!(
        name: row["user_name"],
        mobile_phone_number: row["mobile_phone_number"].present? ? row["mobile_phone_number"] : nil,
        physical_address: row["physical_address"].present? ? row["physical_address"] : nil,
        email_address: row["email_address"].present? ? row["email_address"] : nil,
      )
      ticket = auction.tickets.find_by(number: row["ticket_number"]) || auction.tickets.new(number: row["ticket_number"], price: 30, user: user)
      if ticket.new_record?
        ticket.create_bidder_automatically = false
        ticket.save!
      end
      bidder = auction.bidders.find_by(number: row["bidder_number"]) || auction.bidders.new(number: row["bidder_number"])
      unless bidder.tickets.include? ticket
        bidder.tickets << ticket
      end
      bidder.save!
    end
  end

end
