Given /^the following orders:$/ do |table|
  table.hashes.each do |h|
    Factory(:order, h)
  end
end
