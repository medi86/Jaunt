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

  it "location has a latitude" do
    location = Location.create(latitude: 43.444)
    location.latitude == 43.444
  end

  it "location has a longitude" do
    location = Location.create(longitude: 83.444)
    location.longitude == 83.444
  end
end
