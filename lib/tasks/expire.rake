# Run at midnight
task :expire => :environment do
  Challenge.expire_pending
end
