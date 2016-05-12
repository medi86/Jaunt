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
        self.locations.push({address: address, description: "", name: place.name})
        document.getElementById('addLocation').value = ''

      new google.maps.Marker({map: self.map,
          position: {lat: place.geometry.location.lat(), lng: place.geometry.location.lng()}})
      })
    })

   // $(window).keydown(function(event) {
    //  if(event.keyCode == 13) {
     //  event.preventDefault()
    // }
   // })

   window.onload = function initMap() {
        var myLatLng = {lat: 37.5665, lng: 126.9780}

        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 10,
          minZoom: 4,
          center: myLatLng
        })
        var marker = new google.maps.Marker({
          position: myLatLng,
          map: map,
          title: 'Hello World!'
        })
        self.map = map
  }


       navigator.geolocation.getCurrentPosition(function(position) {
         var pos = {
           lat: position.coords.latitude,
           lng: position.coords.longitude
         }
         self.map.setCenter(pos)
         })

         },

    methods: {
      addJaunt: function() {
        var self = this
        $.ajax({
          method: "POST",
          url: "/jaunts",
          data: {jaunt: {jaunt_title: self.jauntTitle, jaunt_description: self.jauntDescription, addresses: self.locations}}
        }).then(jaunt =>  window.location.replace("/show/"+jaunt.id))
    }}
  })
})();
