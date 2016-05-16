module JauntHelper
  def import(json_jaunt)
    locations = json_jaunt[:locations].map do |pos, loc|
     Location.new(position: pos,
                  name: loc[:name],
                  address: loc[:address],
                  description: loc[:description],
                  latitude: loc[:coordinates][:lat], longitude: loc[:coordinates][:lng]
                 )
    end

    jaunt = current_user.jaunts.find_or_create_by!(id: json_jaunt[:id])
    jaunt.update(title: json_jaunt[:title],
                 description: json_jaunt[:description],
                 locations: locations)
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
    { id: ar_jaunt.id,
      title: ar_jaunt.title,
      description: ar_jaunt.description,
      locations: addresses
    }
  end
end
