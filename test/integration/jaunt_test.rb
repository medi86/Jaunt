require 'test_helper'

class JauntTest < ActionDispatch::IntegrationTest
  def test_a_user_can_create_a_new_jaunt
  start_loc   = "1313 Here Ln, Chicago, Il 12345"
  start_desc  = "I do stuff"
  end_loc     = "3131 There Ln, Chicago, Il 12345"
  end_desc    = "I do other stuff"

  page.visit root_path
  assert page.has_content?("Create a jaunt")
  page.click_link "Create a jaunt"

  assert page.has_content?("Enter a Start location")
  assert page.has_content?("start_location")
  page.fill_in("start_location", with: start_loc)

  assert page.has_content?("What do you do at this location")
  assert page.has_content?("start_description")
  page.fill_in("start_description", with: start_desc)

  assert page.has_content?("Enter a End location")
  assert page.has_content?("end_location")
  page.fill_in("end_location", with: end_loc)

  assert page.has_content?("end_description")
  page.fill_in("end_description", with: end_desc)

  page.click_button "Submit Jaunt"

  assert page.has_content? (start_location)
  assert page.has_content? (start_description)
  assert page.has_content? ("Travel Method: Walking")
  assert page.has_content? (end_location)
  assert page.has_content? (end_description)
  end
end
