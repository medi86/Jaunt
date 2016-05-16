require 'rails_helper'

RSpec.describe('Jaunt', {type: :model}) do
  it "jaunt has a title" do
    jaunt = Jaunt.create(title: "test title")
    jaunt.title == "test title"
  end

  it "jaunt has a description" do
    jaunt = Jaunt.create(description: "test description")
    jaunt.description == "test description"
  end

  it "jaunt has a locations" do
    jaunt = Jaunt.create(locations: [Location.new(name: "test")])
    jaunt.locations.first.name == "test"
  end
end

