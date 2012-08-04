Given /^the following currencies exist:$/ do |table|
  Currency.create!(table.hashes)
end