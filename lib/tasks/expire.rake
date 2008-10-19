# Run at midnight
task :expire => :environment do
  Challenge.pending.each(&:reject!)
end
