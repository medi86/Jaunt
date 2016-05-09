require 'test_helper'

class JauntTest < ActionDispatch::IntegrationTest
  def test_a_user_can_create_a_new_jaunt
  start_location = "National Louis University, 122 South Michigan Avenue, Chicago, IL 60603"
  end_location   = "The Art Institute of Chicago, 111 South Michigan Avenue, Chicago, IL 60603"

  page.visit jaunts_path
  assert page.has_content?("Create a jaunt")
  page.click_link "Create a jaunt"

  assert page.has_content?("start_location")
  assert page.has_content?("end_location")

  page.fill_in("start_location", with: "NLU")
  page.fill_in("end_location", with: "Art Institute of Chicago")

  page.click_button "Submit Jaunt"

  assert page.has_content? (start_location)
  assert page.has_content? (end_location)
  end
end
