require 'rails_helper'

RSpec.describe('JauntHelper', {type: :helper}) do
  it "import pulls data out of json and adds jaunt to database" do
    skip
    json_jaunt = {"jaunt_id"=>"",
                  "jaunt_title"=>"Test Title",
                  "jaunt_description"=>"Test Description",
                  "addresses"=>
                  {"0"=>
                  {"address"=>"3210 N Troy St, Chicago, IL 60618, United States",
                              "description"=>"Test Location",
                              "name"=>"State Testing LLC",
                              "coordinates"=>{"lat"=>"43.22", "lng"=>"-87.77"}}}}
    helper.import(json_jaunt)
    expect(Jaunt.first.title).to eql(json_jaunt["jaunt_title"])
  end

  it "export converts jaunt from active record format to json" do
    skip
    active_record_jaunt = Jaunt.create(title: "test title",
                                       description: "test description",
                                       locations: [Location.new(name: "test name",
                                                                description: "test description",
                                                                latitude: 43.22,
                                                                longitude: 84.44
                                                               )
                                                  ])
    export(active_record_jaunt)
  end
end
