puts "Seeding users..."
5.times do
  u = Factory(:user, :password => 'password')
  puts "Created #{u.email}."
end
