require 'test_helper'

class ZombiesTest < ActionDispatch::IntegrationTest
  fixtures :all # Tells Rails to load all the fixtures

  def sign_up_as(name, graveyard)
    click_link "Sign Up"
    fill_in "Name", with: name
    fill_in "Graveyard", with: graveyard
    click_button "Sign Up"
  end

  test "Anyone can view zombie information" do
    zombie = zombies(:ash)
    visit zombie_url(zombie)

    # Having two assertions in one test here is used as a time saver. If the first assertion fails, the second assertion is not tested.
    assert_equal zombie_path(zombie), current_path
    within("h1") do
      assert has_content?(zombie.name)
    end
  end

  test "Navigation is available to the zombie page" do
    zombie = zombies(:ash)
    tweet = tweets(:hello)
    visit root_url
    within("#tweet_#{tweet.id}") do
      click_link zombie.name
      assert_equal zombie_path(zombie), current_path
    end
  end

  test "should create a new zombie" do
    visit root_url
    sign_up_as("Breins", "BREEEIINS")
    assert has_content?("Welcome Breins"), "Message not displayed"
  end
end


=begin
  Capybara is a gem that simulates a user interactive with the webapp

  visit login_path
  within "div#login-form" do
    fill_in "Login", with: "user@example.com"
    fill_in "Password", with: "secret"
    check "Remember Me"
    click_on "Login"
  end

  click_link 'Homepage'          # Looks for an anchor tag with an href
  click_button 'Save'            # Looks for a button
  click_on 'Link or button text' # Looks for either an anchor tag or a button

  FORMS:
  fill_in 'First Name', with: 'John'
  choose 'A Radio Button'
  check 'A Checkbox'
  uncheck 'A Checkbox'
  attach_file 'Image', '/path/to/image.jpg'
  select 'Option', from: 'Select Box'

  current_path
  current_url

  has_selector? '#zombie_1 h1'
  has_no_selector? '...'
  has_selector? '#zombie_1 h1', text: 'Ash'
  has_selector? '.zombie', count: 5, visible: true
  has_link? # Check for a hyperlink
  has_field? # Check for a form field
  has_css? # DOM elements by CSS (default)
  has_xpath? # DOM elements by XPath
=end
