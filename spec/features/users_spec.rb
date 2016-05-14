require 'rails_helper'

RSpec.describe('users_signup', {type: :feature}) do

  scenario('guest can sign up with right parameters', {js: true}) do
    page.visit root_path
    assert page.has_content?("Sign-up")
    page.click_link("Sign-up")

    assert page.has_content?("Name")
    page.fill_in("user_name", with: "TestName")
    assert page.has_content?("Email")
    page.fill_in("user_email", with: "test@gmail.com")
    assert page.has_content?("Password")
    page.fill_in("user_password", with: "asdf1234")
    assert page.has_content?("Confirmation")
    page.fill_in("user_password_confirmation", with: "asdf1234")

    page.click_button "Create my account"
  end

end
