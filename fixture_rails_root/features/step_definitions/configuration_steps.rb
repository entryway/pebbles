Given /^I configure shipping_calculation_method: "([^"]*)"$/ do |val|
  GeneralConfiguration.instance.update_attribute(:shipping_calculation_method, val)
end
