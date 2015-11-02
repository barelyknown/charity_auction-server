namespace :seed do
  task :bid_types => :environment do
    ["live","silent","teacup","fixed-price","heads-or-tails"].each do |name|
      BidType.find_or_create_by!(name: name)
    end
  end

  task :donation_categories => :environment do
    YAML.load_file(Rails.root.join("db","seeds","donation_categories.yml")).each do |attributes|
      DonationCategory.find_or_create_by!(attributes)
    end
  end
end
