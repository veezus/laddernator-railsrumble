# Run at midnight
task :expire => :environment do
  # accepted challenges?  mark them lost
  # pending challenges?  mark them rejected
  Challenge.pending.each(&:reject!)
end
