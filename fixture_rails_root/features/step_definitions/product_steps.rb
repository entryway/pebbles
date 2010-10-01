Given /^the following products exist:$/ do |table|
  table.hashes.each do |h|
    Factory(:product, h)
  end
end

Given /^I wait (\d+) seconds$/ do |seconds|
  sleep(seconds.to_i)
end
