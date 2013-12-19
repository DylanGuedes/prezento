require 'kalibro_gem/errors'

Given(/^I have a sample reading group$/) do
  @reading_group = FactoryGirl.create(:reading_group, {id: nil})
end

When(/^I am at the Sample Reading Group page$/) do
  page.should have_content(@reading_group.name)
  page.should have_content(@reading_group.description)
end

