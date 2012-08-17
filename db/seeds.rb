DataUpdater.instance.update

user = User.create!(:email => 'test@example.com', :password => '123456', :password_confirmation => '123456')

interval = 300
start_time = Time.now - (interval + 10).days

20.times do
  offset = rand(Country.count)
  rand_country = Country.first(:offset => offset)
  user.visits.create!(:country_id => rand_country.code, :created_at => start_time)
  interval_offset = rand(interval/4)
  interval = interval - interval_offset
  start_time = start_time + interval_offset.days
end