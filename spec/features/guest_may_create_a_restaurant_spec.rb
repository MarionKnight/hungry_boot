require 'spec_helper'
require 'ruby-debug'

feature "Creating restaurant" do
  # The test below is broken-- it gives a false positive
  # It duplicates active record validations and rspec tests
  # So it doesn't really have to exist. Note to self: don't
  # test this kind of shit with capybara. Only use it to test
  # straightforward URL stuff.
  #
  # scenario "Guest may not create a restaurant with no cuisine" do
  #   visit '/restaurants/new'
  #   fill_in "name", with: "Pasilla"
  #   fill_in "location", with: "Down Pine"
  #   click_on "Record Restaurant!"
  #   # debugger, invoke wiht rspec -d spec/features

  #   expect(page).to have_content("This test should fail")
  # end

  scenario "Guest may create a restaurant with a cuisine" do
    visit '/restaurants/new'
    fill_in "name", with: "Pasilla"
    fill_in "location", with: "Down Pine"
    fill_in "cuisine", with: "Mexican"
    click_on "Record Restaurant!"

    expect(page).to have_content("Restaurant: Pasilla, Located at Down Pine, Cuisine: Mexican!")
  end

end
