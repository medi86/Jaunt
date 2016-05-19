module JauntHelper
  def import(json_jaunt)
    default_website = "A website is not available for this location"
    default_phone = "No phone number is available for this location"
    default_hours = "Hours of operation are not available for this location"

    locations = json_jaunt[:locations].map do |pos, loc|
     Location.new(position: pos,
                  name: loc[:name],
                  address: loc[:address],
                  description: loc[:description],
                  website: loc[:website] ? loc[:website] : default_website,
                  phone_number: loc[:phone_number] ? loc[:phone_number] : default_phone,
                  hours: loc[:hours] ? loc[:hours].join("\n") : default_hours
                 )
    end

    jaunt = current_user.jaunts.find_or_create_by!(id: json_jaunt[:id])
    jaunt.update(title: json_jaunt[:title],
                 description: json_jaunt[:description],
                 locations: locations)
    Jaunt.find_by_id(jaunt.id)
  end

  def export(ar_jaunt)
    default_hours = "Hours of operation are not available for this location"

    locations = ar_jaunt.locations.map do |loc|
      { address: loc.address,
        name: loc.name,
        description: loc.description,
        website: loc.website,
        phone_number: loc.phone_number,
        hours: loc.hours == default_hours ? loc.hours : loc.hours.split("\n")
      }
    end
    { id: ar_jaunt.id,
      title: ar_jaunt.title,
      description: ar_jaunt.description,
      locations: locations
    }
  end
end
