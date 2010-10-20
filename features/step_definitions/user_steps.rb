Given /^I am signed in(?: as an? (.*))?$/ do |role|
  role ||= 'user'
  role = role.strip
  
  user = Factory(role)
  Given %{I sign in as "#{user.email}/#{user.password}"}
end

Then /^I should not be signed in$/ do
  Then %{I should be signed out}
end

Then /^I should see a list of users$/ do
  page.should have_css('tbody tr', :count => 20)
end

# General

Then /^I should see error messages$/ do
  assert_match /error(s)? prohibited/m, response.body
end

# Database

Given /^no user exists with an email of "(.*)"$/ do |email|
  assert_nil User.find_by_email(email)
end

Given /^I have an account "(.*)\/(.*)"$/ do |email, password|
  user = Factory :user,
    :email                 => email,
    :password              => password,
    :password_confirmation => password
end 

Given /^I am signed up and confirmed as a (.+)$/ do |role|
  user = create_model(role).first
  
  user.confirm_email!
end

Given /^I sign in as a (.+)$/ do |role|
  user = create_model(role).first
  user.confirm_email!
  Given %{I sign in as "#{user.email}\/#{user.password}"}
end

# Session

Then /^I should be signed in$/ do
  Then %{I should see "Signed in successfully"}
end

Then /^I should be signed in as a(?:n|) (.*)$/ do |role|
  assert controller.signed_in?
  compare_user = create_model(role).first
  controller.current_user.role.should == compare_user.role
  compare_user.destroy
end

Then /^I should be signed out$/ do
  assert_not @env['warden'].authenticated?(:user)
end

When /^session is cleared$/ do
  request.reset_session
  controller.instance_variable_set(:@_current_user, nil)
end

Given /^I have signed in with "(.*)\/(.*)"$/ do |email, password|
  Given %{I am signed up and confirmed as "#{email}/#{password}"}
  And %{I sign in as "#{email}/#{password}"}
end

# Emails

Then /^a confirmation message should be sent to "(.*)"$/ do |email|
  user = User.find_by_email(email)
  assert !user.confirmation_token.blank?
  assert !ActionMailer::Base.deliveries.empty?
  result = ActionMailer::Base.deliveries.any? do |email|
    email.to == [user.email] &&
    email.subject =~ /confirm/i &&
    email.body =~ /#{user.confirmation_token}/
  end
  assert result
end

When /^I follow the confirmation link sent to "(.*)"$/ do |email|
  user = User.find_by_email(email)
  visit new_user_confirmation_path(:user_id => user,
                                   :token   => user.confirmation_token)
end

Then /^a password reset message should be sent to "(.*)"$/ do |email|
  user = User.find_by_email(email)
  assert !user.confirmation_token.blank?
  assert !ActionMailer::Base.deliveries.empty?
  result = ActionMailer::Base.deliveries.any? do |email|
    email.to == [user.email] &&
    email.subject =~ /password/i &&
    email.body =~ /#{user.confirmation_token}/
  end
  assert result
end

When /^I follow the password reset link sent to "(.*)"$/ do |email|
  user = User.find_by_email(email)
  visit edit_user_password_path(:user_id => user,
                                :token   => user.confirmation_token)
end

When /^I try to change the password of "(.*)" without token$/ do |email|
  user = User.find_by_email(email)
  visit edit_user_password_path(:user_id => user)
end

Then /^I should be forbidden$/ do
  assert_response :forbidden
end

# Actions

When /^I sign in as "(.*)\/(.*)"$/ do |email, password|
  When %{I go to the sign in page}
  And %{I fill in "user_email" with "#{email}"}
  And %{I fill in "user_password" with "#{password}"}
  And %{I press "Sign in"}
end

When /^I sign out$/ do
  visit destroy_user_session_path
end

When /^I request password reset link to be sent to "(.*)"$/ do |email|
  When %{I go to the password reset request page}
  And %{I fill in "Email address" with "#{email}"}
  And %{I press "Reset password"}
end

When /^I update my password with "(.*)\/(.*)"$/ do |password, confirmation|
  And %{I fill in "Choose password" with "#{password}"}
  And %{I fill in "Confirm password" with "#{confirmation}"}
  And %{I press "Save this password"}
end

When /^I return next time$/ do
  When %{session is cleared}
  And %{I go to the homepage}
end

Then /^the user should be able to sign in as "(.*)\/(.*)"$/ do |email, password|
  Given %{I sign out}
  And %{I sign in as "#{email}/#{password}"}
  Then %{I should be signed in}
end

