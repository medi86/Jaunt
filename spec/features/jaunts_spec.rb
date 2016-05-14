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

   scenario('a user can navigate the page', {js: true}) do
    page.visit root_path
    assert page.has_content?("Find a Jaunt")
    page.click_link("Find a Jaunt")

    expect(page.current_path).to eql('/index')
    assert page.has_link?('Create Jaunts')
    page.click_link("Create Jaunts")

    expect(page.current_path).to eql('/new')
    assert page.has_link?("Sign-up")
    page.click_link("Sign-up")

    expect(page.current_path).to eql('/signup')
  end

   scenario('a user can find a jaunt', {js: true}) do
     jaunt = Jaunt.create!(title: 'testJaunt', description: 'testDescription',
                   locations: [Location.new(address: '123 fake st', latitude: 41.23, longitude: -87.23), Location.new(address: '123 superfake st', latitude: 49.23, longitude: -82.23)])
     page.visit root_path
     page.click_link('Find a Jaunt')
     assert page.has_content?('testJaunt')
     page.click_link('testJaunt')
     expect(page.current_path).to eql("/show/#{jaunt.id}")
     assert page.has_content?(jaunt.description)
     assert page.has_content?(jaunt.locations.first.address)
     assert page.has_content?(jaunt.locations.first.description)
     assert page.has_content?(jaunt.locations.last.address)
     assert page.has_content?(jaunt.locations.last.description)
   end
end
