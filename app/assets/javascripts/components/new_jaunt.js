;(function () {
  "use strict"

  Vue.component("vue-new-jaunt", {
  template: "#new-jaunt-template",

  data: function() {
    return {
      jauntTitle: "",
      jauntDescription: "",
      locations: [],
      map: {}
    }
  },

  ready: function() {
    var self = this

    google.maps.event.addDomListener(window, 'load', function () {
      var places = new google.maps.places.Autocomplete(document.getElementById('addLocation'));
      google.maps.event.addListener(places, 'place_changed', function () {
        var place = places.getPlace();
        var address = place.formatted_address;
        if (!address){ return false }

        var coords = {lat: place.geometry.location.lat(), lng: place.geometry.location.lng()}
        self.locations.push({address: address, description: "", name: place.name, coordinates: coords})
        document.getElementById('addLocation').value = ''

        new google.maps.Marker({map: self.map, position: coords})
      })
    })

    window.onload = function initMap() {
      var myLatLng = {lat: 41.8781, lng: 87.6298}

      var map = new google.maps.Map(document.getElementById('map'), {
        zoom: 10,
        minZoom: 9,
        center: myLatLng
      })
      var marker = new google.maps.Marker({
        position: myLatLng,
        map: map
      })
      self.map = map
    }
     $('#jaunt-locations').height(($('#jaunt-map').height() + $('#jaunt-desc').height()) - 50)
   },

   methods: {
     addJaunt: function() {
       var self = this
       $.ajax({
         method: "POST",
         url: "/jaunts",
         data: {jaunt: {jaunt_title: self.jauntTitle, jaunt_description: self.jauntDescription, addresses: self.locations}}
       }).then(function(jaunt) { window.location.replace("/show/"+jaunt.id)})
    }
   }
  })
})();
