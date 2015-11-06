class DonorLoader do

  attr_reader :auction, :csv

  def initialize(auction, csv)
    @auction, @csv = auction, csv
  end
end
