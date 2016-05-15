;(function () {
  "use strict"

  Vue.component("vue-jauntform", {
  template: "#jaunt-form-template",

  data: function() {
    return {
      jauntTitle: "",
      jauntDescription: "",
      locations: [],
      markers: [],
      editForm: false
    }
  },

  ready: function() {
    var self = this

    google.maps.event.addDomListener(window, 'load', function () {
      var places = new google.maps.places.Autocomplete(document.getElementById('addLocation'));
      var bounds = new google.maps.LatLngBounds()
      google.maps.event.addListener(places, 'place_changed', function () {
        var place = places.getPlace();
        var address = place.formatted_address;
        if (!address){ return false }

        var coords = {lat: place.geometry.location.lat(), lng: place.geometry.location.lng()}
        self.locations.push({address: address, description: "", name: place.name, coordinates: coords})
        document.getElementById('addLocation').value = ''

        var marker = new google.maps.Marker({map: self.map, position: coords})
        var latLng = marker.getPosition()
        self.markers.push(marker)
        bounds.extend(marker.position)
        self.map.fitBounds(bounds)
      })
    })

    if(gon.jaunt) {
      self.jauntTitle = gon.jaunt.jaunt_title
      self.jauntDescription = gon.jaunt.jaunt_description
      self.locations = gon.jaunt.addresses
      self.editForm = true
    }

    window.onload = function initMap() {
      var myLatLng = {lat: 41.8803, lng: -87.6249}

      var map = new google.maps.Map(document.getElementById('map'), {
        zoom: 9,
        minZoom: 3,
        center: myLatLng
      })
      self.map = map

      if(gon.jaunt) {
        gon.jaunt.addresses.forEach(function(loc) {
          var marker = new google.maps.Marker({map: self.map, position: loc.coordinates})
          self.markers.push(marker)
        })
      }
    }
     $('#jaunt-locations').height(($('#jaunt-map').height() + $('#jaunt-desc').height()) - 50)
   },

   methods: {
     addJaunt: function() {
     var self = this

     var checkLocations = function(locations) {
         locations.forEach(function(loc) {
           if (loc.description === "") {
             return true
           }
         })
         return false
     }

     var changeLocations = function(locations) {
       locations.forEach(function(loc, index) {
         if(loc.description === "") {
           $("#location-" + index).toggleClass("panel-danger")
           $("#location-" + index + "-text").attr("placeholder", "Please enter a description")
         }
       })
     }

     if(self.locations.length === 0) {
       $("#locationPanel").toggleClass("panel-danger")
       $("#locationsPlaceholder").html("Please enter at least one location for your jaunt")

     } else if(self.jauntTitle === "") {
       $("#jaunt-title").toggleClass("panel-danger")
       $("#jaunt-title-text").attr("placeholder", "Please enter a title")

     } else if(self.jauntDescription === "") {
       $("#jaunt-desc").toggleClass("panel-danger")
       $("#jaunt-desc-text").attr("placeholder", "Please enter a description")

     } else if(checkLocations(self.locations)) {
       changeLocations(self.locations)

     } else {
       $.ajax({
         method: "POST",
         url: "/jaunts",
         data: {jaunt: {jaunt_title: self.jauntTitle, jaunt_description: self.jauntDescription, addresses: self.locations}}
       }).then(function(jaunt) { window.location.replace("/show/"+jaunt.id)})
     }
    },

    moveLocationInList: function(from, to) {
      this.locations.splice(to, 0, this.locations.splice(from, 1)[0]);
      this.markers.splice(to, 0, this.markers.splice(from, 1)[0]);
    },

    deleteLocation: function(index, location){
      this.locations.splice(index, 1)
      this.markers[index].setMap(null)
      this.markers.splice(index, 1)
    }
   }
  })
})();
