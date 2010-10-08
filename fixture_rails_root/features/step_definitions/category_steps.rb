Given /^the following categories:$/ do |table|
  table.hashes.each do |h|
    Factory(:category, h)
  end
end
