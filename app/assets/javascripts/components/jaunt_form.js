;(function () {
  "use strict"

  Vue.component("vue-jauntform", {
  template: "#jaunt-form-template",
  props: ["jaunt"],
  data: function() {
    return {
      editForm: gon.editPage,
    }
  },

  ready: function() {
    var self = this
    self.directionsService = new google.maps.DirectionsService
    self.directionsDisplay = new google.maps.DirectionsRenderer

     self.map = new google.maps.Map(self.$els.map, {
      zoom: 10,
      minZoom: 3,
      maxZoom: 16,
      center: {lat: 41.8803, lng: -87.6249}
    })

    self.directionsDisplay.setMap(self.map)
    if(gon.editPage) {self.getDirections(); self.editPage = false}

    google.maps.event.addDomListener(window, 'load', function () {
      var places = new google.maps.places.Autocomplete(self.$els.addLocation)
      google.maps.event.addListener(places, 'place_changed', function () {
        var place = places.getPlace()
        var address = place.formatted_address
        if (!address){ return false }
        window.place = place;
        self.addLocation(place, address)
        self.$els.addLocation.value = ''
        self.getDirections()
       })
      })

    $('#jaunt-locations').height(($('#jaunt-map').height() + $('#jaunt-desc').height()) - 50)
   },

   methods: {
     addJaunt: function() {
       var self = this

       if(self.jaunt.locations.length === 0) {
         self.$els.locationsPanel.className = "panel panel-danger"
         $("#locationsPlaceholder").html("Please enter at least one location for your jaunt")

       } else if(!self.jaunt.title) {
         self.$els.jauntTitle.className = "panel panel-danger"
         $("#jaunt-title-text").attr("placeholder", "Please enter a title")

       } else if(!self.jaunt.description) {
         self.$els.jauntDescription.className = "panel panel-danger"
         $("#jaunt-desc-text").attr("placeholder", "Please enter a description")

       } else if(self.locationDescriptionEmpty()) {
         self.changeLocationClass()

       } else {
         $.ajax({
           method: "POST",
           url: "/jaunts",
           data: {jaunt: {id: self.jaunt.id,
                          title: self.jaunt.title,
                          description: self.jaunt.description,
                          locations: self.jaunt.locations}}
         }).then(function(jaunt) { window.location.replace("/show/"+jaunt.id)})
       }
    },

     addLocation: function(place, address) {
      var location = { address: address, description: "", name: place.name}

      if(place.formatted_phone_number) {
        location.phone_number = place.formatted_phone_number
      } else {
        location.phone_number = "No phone number is available"
      }

      if (place.website) {
        location.website = place.website
      } else {
        location.website = "No website is available"
      }

      if (place.opening_hours) {
        location.hours = place.opening_hours.weekday_text.join("\n")
      } else {
        location.hours = "No hours of operation available"
      }

      this.jaunt.locations.push(location)
     },

     moveLocationInList: function(from, to) {
       this.jaunt.locations.splice(to, 0, this.jaunt.locations.splice(from, 1)[0]);
       this.getDirections()
     },

     deleteLocation: function(index, location){
       this.jaunt.locations.splice(index, 1)
       this.getDirections()
     },

     locationDescriptionEmpty: function() {
       var returnVal = false
        this.jaunt.locations.forEach(function(loc) {
           if(loc.description === "") {
             returnVal = true
           }
         })
      return returnVal
     },

     changeLocationClass: function() {
       this.jaunt.locations.forEach(function(loc, index) {
          if(loc.description === "") {
            $("#location-" + index).toggleClass("panel-danger")
            $("#location-" + index + "-text").attr("placeholder", "Please enter a description")
          }
        })
      },

     getDirections: function() {
       var self = this
       var waypoints = []

       if(self.jaunt.locations.length > 2) {
         self.jaunt.locations.slice(1, self.jaunt.locations.length - 1).forEach( function(jauntLocation) {
           waypoints.push({location: jauntLocation.address})
         })
       }

       self.directionsService.route({
         origin: self.jaunt.locations[0].address,
         destination: self.jaunt.locations[self.jaunt.locations.length - 1].address,
         waypoints: waypoints,
         travelMode: google.maps.TravelMode.WALKING
         }, function(response) { self.directionsDisplay.setDirections(response)})
     },
   }
 })
})();
