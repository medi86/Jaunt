module JauntHelper
  def import(json_jaunt)
    locations = json_jaunt[:locations].map do |pos, loc|
     Location.new(position: pos,
                  name: loc[:name],
                  address: loc[:address],
                  description: loc[:description],
                 )
    end

    jaunt = current_user.jaunts.find_or_create_by!(id: json_jaunt[:id])
    jaunt.update(title: json_jaunt[:title],
                 description: json_jaunt[:description],
                 locations: locations)
    Jaunt.find_by_id(jaunt.id)
  end

  def export(ar_jaunt)
    locations = ar_jaunt.locations.map do |loc|
      { address: loc.address,
        name: loc.name,
        description: loc.description,
      }
    end
    { id: ar_jaunt.id,
      title: ar_jaunt.title,
      description: ar_jaunt.description,
      locations: locations
    }
  end
end
