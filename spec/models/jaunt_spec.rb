require 'rails_helper'

RSpec.describe('Location', {type: :model}) do
  it "location has a name" do
    location = Location.create(name: "test name")
    location.name == "test name"
  end

  it "location has a description" do
    location = Location.create(description: "test description")
    location.description == "test description"
  end
end
