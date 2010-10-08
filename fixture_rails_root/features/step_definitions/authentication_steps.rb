Given /^I am logged in as an admin$/ do
  admin = Factory(:admin)
  Given %Q{I am on the login page}
  Given %Q{I fill in "login" with "#{admin.login}"}
  Given %Q{I fill in "password" with "password"}
  Given %Q{I press "Log in"}
end
