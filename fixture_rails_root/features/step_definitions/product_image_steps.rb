Given /^I attach a regular product image "([^"]*)"$/ do |image_name|
  attach_file('product_image_filename', "#{Rails.root}/features/fixtures/#{image_name}")
end
