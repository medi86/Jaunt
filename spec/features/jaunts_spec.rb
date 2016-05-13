require 'rails_helper'

RSpec.describe('jaunts', {type: :feature}) do
  scenario('dbcleanertest',{js: true}) do
    page.visit jaunts_path
    refute page.has_content?("OMG")
    Jaunt.create!(title: "OMG", description: "Test Description", locations: [Location.new(address: "Test Place", description: "We do tests")])
    page.visit jaunts_path
    assert page.has_content?("OMG")
  end
end
