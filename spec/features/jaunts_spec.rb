require 'rails_helper'

RSpec.describe('jaunts', {type: :feature}) do

   scenario('a user can create a new jaunt', {js: true}) do
    nlu = "National Louis University, 122 South Michigan Avenue, Chicago, IL 60603"
    art = "The Art Institute of Chicago, 111 South Michigan Avenue, Chicago, IL 60603"

    page.visit root_path
    assert page.has_content?("Create a Jaunt")
    page.click_link("Create a Jaunt")

    assert page.has_content?("Jaunt Title")
    page.fill_in("Give this jaunt a name", with: "Test Title")
    assert page.has_content?("Jaunt Description")
    page.fill_in("Tell us about what you do on this jaunt...", with: "Test Description")

    page.fill_in("Add a location", with: "national louis university")
    page.find_by_id("addLocation").native.send_key(:arrow_down)
    page.find_by_id("addLocation").native.send_key(:enter)
    page.fill_in("Add a location", with: "art institute")
    page.find_by_id("addLocation").native.send_key(:arrow_down)
    page.find_by_id("addLocation").native.send_key(:enter)

    page.click_button "Create Jaunt"
  end

   scenario('test a user can find a jaunt', {js: true}) do
    Jaunt.create!(title: "Test", description: "Test Description",
                  locations: [Location.new(address: "Test Place", description: "We do tests")])

    page.visit jaunts_path

    assert page.has_content?("Test")
    assert page.has_content?("Test Description")
    page.click_link("Test")
    assert page.has_content?("Test Place")
    assert page.has_content?("We do tests")
  end
end
