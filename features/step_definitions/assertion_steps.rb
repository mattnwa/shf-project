

Then(/^I should be on the landing page$/) do
  expect(current_path).to eq root_path
end

And(/^I should see "([^"]*)"$/) do |content|
  expect(page).to have_content content
end

And(/^I should not see "([^"]*)"$/) do |content|
  expect(page).not_to have_content content
end

And(/^I should not see button "([^"]*)"$/) do |button|
  expect(page).not_to have_button button
end



Then(/^I should be on "([^"]*)" page$/) do |page|
  case page.downcase
    when  'login'
      path = new_user_session_path
    when 'landing'
      path = root_path
    when 'edit my application'
      path = edit_membership_application_path(@user.membership_applications.last)
  end
  expect(current_path).to eq path
end


Then(/^I should see:$/) do |table|
  table.hashes.each do |hash|
    expect(page).to have_content hash[:content]
  end
end

And(/^"([^"]*)" should be set in "([^"]*)"$/) do |status, list|
  dropdown = page.find("##{list}")
  selected_option = dropdown.find('option[selected]').text
  expect(selected_option).to eql status
end

Then(/^I should be on the application page for "([^"]*)"$/) do |first_name|
  membership_application = MembershipApplication.find_by(first_name: first_name)
  expect(current_path).to eq membership_application_path(membership_application)
end

Then(/^I should be on the edit application page for "([^"]*)"$/) do |first_name|
  membership_application = MembershipApplication.find_by(first_name: first_name)
  expect(current_path).to eq edit_membership_application_path(membership_application)
end


Then(/^I should see "([^"]*)" applications$/) do |number|
  expect(page).to have_selector('.applicant', count: number)
end

Then(/^the field "([^"]*)" should have a required field indicator$/) do |label_text|
  expect(page.find('label', text: label_text)[:class].include?('required')).to be true
end

And(/^the field "([^"]*)" should not have a required field indicator$/) do |label_text|
  expect(page.find('label', text: label_text)[:class]).not_to have_css 'required'
end

Then(/^I should see (\d+) (.*?) rows$/) do |n, css_class_name|
  n = n.to_i
  expect(page).to have_selector(".#{css_class_name}", count: n)
  expect(page).not_to have_selector(".#{css_class_name}", count: n+1)
end
