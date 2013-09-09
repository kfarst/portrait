require File.expand_path(File.dirname(__FILE__) + '/../lib/password')

unless password = ENV['password']
  puts "Please add a password for the admin user with 'rake db:seed password=[password]'"
  exit
end

begin
  user = User.new({name: 'admin', password: password, admin: true})
  user.build_subscription
  user.save!
  puts 'admin user created.'
rescue ActiveRecord::RecordInvalid => e
  if e.message =~ /Name has already been taken/
    puts "Already created admin user"
  else
    puts "Could not create admin user because: #{e.message}"
  end
end
