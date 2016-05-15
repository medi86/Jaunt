module JauntHelper
  def import(json_jaunt)
    addresses = json_jaunt[:addresses].map do |pos, loc|
     Location.new(position: pos,
                  name: loc[:name],
                  address: loc[:address],
                  description: loc[:description],
                  latitude: loc[:coordinates][:lat], longitude: loc[:coordinates][:lng]
                 )
    end

    jaunt = current_user.jaunts.find_or_create_by!(id: json_jaunt[:jaunt_id].to_i)
    jaunt.update(title: json_jaunt[:jaunt_title],
                 description: json_jaunt[:jaunt_description],
                 locations: addresses)
    Jaunt.find_by_id(jaunt.id)
  end

  def export(ar_jaunt)
    addresses = ar_jaunt.locations.map do |loc|
      { address: loc.address,
        name: loc.name,
        description: loc.description,
        coordinates: {lat: loc.latitude, lng: loc.longitude}
      }
    end
    { jaunt_id: ar_jaunt.id,
      jaunt_title: ar_jaunt.title,
      jaunt_description: ar_jaunt.description,
      addresses: addresses
    }
  end
end
