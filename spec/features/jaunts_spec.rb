require 'rails_helper'

RSpec.describe('jaunts', {type: :feature}) do

   scenario('a user can create a new jaunt', {js: true}) do
    start_location = "National Louis University, 122 South Michigan Avenue, Chicago, IL 60603"
    end_location   = "The Art Institute of Chicago, 111 South Michigan Avenue, Chicago, IL 60603"

    page.visit root_path
    assert page.has_content?("Create a Jaunt")
    skip
    page.click_link("Create a Jaunt")

    assert page.has_content?("Jaunt Title:")
    page.fill_in(i"start_location", with: "NLU")
    assert page.has_content?("Jaunt Description:")
    assert page.has_content?("End Location: ")

    page.fill_in("start_location", with: "NLU")
    page.fill_in("end_location", with: "Art Institute of Chicago")

    page.click_button "Submit Jaunt"

    assert page.has_content? (start_location)
    assert page.has_content? (end_location)
  end

   scenario('test a user can find a jaunt', {js: true}) do
    Jaunt.create!(title: "Test", description: "Test Description",
                  locations: [Location.new(address: "Test Place", description: "We do tests")])

    page.visit jaunts_path

    assert page.has_content?("Test")
    assert page.has_content?("Test Description")
    skip
    page.click_link("Test")
    assert page.has_content?("Test Place")
    assert page.has_content?("We do tests")
  end
end
