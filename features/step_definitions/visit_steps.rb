Given /^the following visits exist:$/ do |table|
  table.hashes.each do |hash|
    user = User.find_by_email(hash[:email])
    Visit.create!(:user_id => user.id, :country_id => hash[:code])
  end
end