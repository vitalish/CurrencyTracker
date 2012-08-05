Given /the following countries exist:/ do |countries|
  Country.create!(countries.hashes)
end

Then /^I should see the following table:$/ do |expected_table|
  document = Nokogiri::HTML(page.body)
  rows = document.css('.smart_table tr').collect { |row| row.xpath('.//th|td').collect {|cell| cell.text } }

  expected_table.diff!(rows)
end

When /^I select country with code "([^"]*)"$/ do |code|
  page.all('.smart_table tr').each do |tr|
    found = tr.find('td', :text => code) rescue nil
    if found
      tr.check('countries[]')
    end
  end
end