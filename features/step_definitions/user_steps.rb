Given /^I am registered user with email "([^"]*)" and password "([^"]*)"$/ do |email, password|
  User.create!(:email => email, :password => password, :password_confirmation => password)
end

Given /^I am logged in user$/ do
  email = 'testuser@example.com'
  password = '123456'
  User.create!(:email => email, :password => password, :password_confirmation => password)
  Given %{I am logged in user with email "#{email}" and password "#{password}"}
end

Given /^the following users exist:$/ do |table|
  table.hashes.each do |hash|
    hash[:password_confirmation] = hash[:password]
    User.create!(hash)
  end
end

Given /^I am logged in user with email "([^"]*)" and password "([^"]*)"$/ do |email, password|
  And %{I am on the home page}
  When %{I fill in "Email" with "#{email}"}
  And %{I fill in "Password" with "#{password}"}
  And %{I press "Sign in"}
end