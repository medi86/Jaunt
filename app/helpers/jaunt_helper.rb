module JauntHelper
  def import(json_jaunt)
    require "pry"
    binding.pry
    addresses = json_jaunt[:addresses].map do |pos, loc|
     Location.new(position: pos, address: loc[:address], description: loc[:description],
                  latitude: loc[:coordinates][:lat], longitude: loc[:coordinates][:lng]
                 )
    end

    current_user.jaunts.create(title: json_jaunt[:jaunt_title],
                               description: json_jaunt[:jaunt_description],
                               locations: addresses)
  end

  def export(ar_jaunt)
    addresses = ar_jaunt.locations.map do |loc|
      { address: loc.address,
        description: loc.description,
        coordinates: {lat: loc.latitude, lng: loc.longitude}
      }
    end
    { jaunt_title: ar_jaunt.title,
      jaunt_description: ar_jaunt.description,
      addresses: addresses
    }
  end
end
