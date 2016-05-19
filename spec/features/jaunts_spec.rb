require 'rails_helper'

RSpec.describe('Full Site', {type: :feature}) do

  scenario('a user can create a new jaunt', {js: true}) do
    user = User.create!(name: "dongmin", email: "medi8600@gmail.com", password: "asdf1234")

    page.visit login_path
    page.fill_in("session_email", with: "medi8600@gmail.com")
    page.fill_in("session_password", with: "asdf1234")
    page.click_button "Log in"

    page.visit new_jaunt_path
    assert page.has_content?("Jaunt Title")
    page.fill_in("Give this jaunt a name", with: "Test Title")

    assert page.has_content?("Jaunt Description")
    page.fill_in("Tell us about what you do on this jaunt...", with: "Test Description")

    page.fill_in("Add a location", with: "national louis")
    page.find_by_id("addLocation").native.send_keys(:arrow_down)
    page.find_by_id("addLocation").native.send_keys(:return)
    page.find_by_id("addLocation").native.send_keys(:arrow_down)
    page.find_by_id("addLocation").native.send_keys(:return)

    page.fill_in("location-0-text", with: "hell")

    page.click_button("Create Jaunt")
    assert page.has_content?("122 S Michigan Ave")
  end

  scenario('a user who is logged-in can navigate the entire page', {js: true}) do
    user = User.create!(name: "dongmin", email: "medi8600@gmail.com", password: "asdf1234")

    jaunt = Jaunt.create!(title: 'testJaunt', description: 'testDescription', locations:
                  [Location.new(address: '123 fake st', name: "fake name", website:"nope", phone_number: "nope", hours: "nope")])

    page.visit login_path
    page.fill_in("session_email", with: "medi8600@gmail.com")
    page.fill_in("session_password", with: "asdf1234")
    page.click_button "Log in"

    page.visit root_path
    assert page.has_content?("Find a Jaunt")
    page.click_link("Find a Jaunt")
    expect(page.current_path).to eql('/search')

    assert page.has_content?("testJaunt")
    page.click_link("testJaunt")
    expect(page.current_path).to eql("/show/#{jaunt.id}")

    assert page.has_content?("Create Jaunts")
    page.click_link("Create Jaunts")
    expect(page.current_path).to eql('/new')
  end

  scenario('a user who is not-logged-in can only navigate the non-user sections of the page', {js: true}) do
    jaunt = Jaunt.create!(title: 'testJaunt', description: 'testDescription', locations:
                  [Location.new(address: '123 fake st', name: "fake name", website:"nope", phone_number: "nope", hours: "nope")])

    page.visit root_path
    assert page.has_content?("Find a Jaunt")
    page.click_link("Find a Jaunt")
    expect(page.current_path).to eql('/search')

    assert page.has_content?("testJaunt")
    page.click_link("testJaunt")
    expect(page.current_path).to eql("/show/#{jaunt.id}")

    assert page.has_link?("Sign-up")
    page.click_link("Sign-up")
    expect(page.current_path).to eql('/signup')

    page.visit login_path
    assert page.has_content?("Log in")
    expect(page.current_path).to eql('/login')

    assert page.has_content?("Create Jaunts")
    page.click_link("Create Jaunts")
    expect(page.current_path).to eql('/signup')
  end

  scenario('a user can find a jaunt', {js: true}) do
    jaunt = Jaunt.create!(title: 'testJaunt', description: 'testDescription',
                          locations: [Location.new(address: '123 fake st', name: "fake name", website:"nope", phone_number: "nope", hours: "nope"),
                                      Location.new(address: '123 superfake st', name: "superfake name", website:"nope", phone_number: "nope", hours: "nope")])
    page.visit search_path
    assert page.has_content?('testJaunt')
    page.click_link('testJaunt')
    expect(page.current_path).to eql("/show/#{jaunt.id}")

    assert page.has_content?(jaunt.description)
    assert page.has_content?(jaunt.locations.first.address)
    assert page.has_content?(jaunt.locations.first.description)
    assert page.has_content?(jaunt.locations.last.address)
    assert page.has_content?(jaunt.locations.last.description)
  end

  scenario('a user can create a new account') do

    page.visit "/signup"
    page.fill_in("user_name",                  with: "Test User")
    page.fill_in("user_email",                 with: "test@testy.test")
    page.fill_in("user_password",              with: "testtest")
    page.fill_in("user_password_confirmation", with: "testtest")
    page.click_button "Create my account"

    test_user = User.first
    expect(test_user.name).to eql("Test User")
    expect(page.current_path).to eql("/users/#{test_user.id}")
    assert page.has_content?("Test User's Jaunts")
  end
end
