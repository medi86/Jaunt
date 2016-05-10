;(function () {
  "use strict"

  Vue.component("vue-jaunts", {
    template: "#jaunts-template",

    data: function() {
      return {
        jauntTitle: "",
        locations: [],
      }
    },

    ready: function() {
      var self = this

      google.maps.event.addDomListener(window, 'load', function () {
        var places = new google.maps.places.Autocomplete(document.getElementById('addLocation'));
        google.maps.event.addListener(places, 'place_changed', function () {
          var place = places.getPlace();
          var address = place.formatted_address;
          self.locations.push(address)
          document.getElementById('addLocation').value = ''
        })
      })

      $(window).keydown(function(event) {
        if(event.keyCode == 13) {
          event.preventDefault()
        }
      })
    },

    methods: {
      addJaunt: function() {
        var self = this
        $.ajax({
          method: "POST",
          url: "/",
          data: {jaunt: {title: self.jauntTitle, addresses: self.locations}}
        })
    }}
  })
})();
