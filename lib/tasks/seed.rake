namespace :seed do
  task :bid_types => :environment do
    ["live","silent","teacup"].each do |name|
      BidType.find_or_create_by!(name: name)
    end
  end
end
