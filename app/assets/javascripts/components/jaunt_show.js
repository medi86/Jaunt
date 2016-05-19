;(function () {
  "use strict"

  Vue.component("vue-jauntshow", {
    template: "#show-jaunt-template",
    props: ["jaunt"],
    data: function() {
      return {
        directionsVisable: false
      }
    },

    ready: function() {
      var self = this
      self.directionsService = new google.maps.DirectionsService
      self.directionsDisplay = new google.maps.DirectionsRenderer
      self.directionsDisplay.setPanel(self.$els.directionsPanel)

       self.map = new google.maps.Map(self.$els.map, {
        zoom: 10,
        minZoom: 3,
        maxZoom: 16,
        center: {lat: 41.8803, lng: -87.6249}
      })
      self.directionsDisplay.setMap(self.map)
      var waypoints = []
      console.log(self.jaunt)

      if(self.jaunt.locations.length > 2) {
        self.jaunt.locations.slice(1, self.jaunt.locations.length - 1).forEach( function(jauntLocation) {
          waypoints.push({location: jauntLocation.address})
        })
      }
      console.log(self.jaunt.locations)

      self.directionsService.route({
        origin: self.jaunt.locations[0].address,
        destination: self.jaunt.locations[self.jaunt.locations.length - 1].address,
        waypoints: waypoints,
        travelMode: google.maps.TravelMode.WALKING
        }, function(response) { self.directionsDisplay.setDirections(response)})

      $('#jaunt-locations').height(($('#jaunt-map').height() + $('#jaunt-title').height()) - 50)
     },

    methods: {
      directionsToggle: function(){
        this.directionsVisable = !this.directionsVisable
        console.log(this.directionsVisable)
      }
    }
  })
})();
