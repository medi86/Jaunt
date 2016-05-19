;(function () {
  "use strict"

  Vue.component("vue-jauntsearch", {
    template: "#search-jaunt-template",
    data: function() {
      return {
        jaunts: []
      }
    },

    ready: function() {
      var self = this
      self.jaunts = gon.jaunts
      google.maps.event.addDomListener(window, 'load', function () {
        var places = new google.maps.places.Autocomplete(self.$els.autoComplete)
        google.maps.event.addListener(places, 'place_changed', function () {
          var place = places.getPlace()
          var address = place.formatted_address
          if (!address){ return false }

          $.ajax({
            method: "POST",
            url: "/search",
            data: { address: address }

          }).then(function(jaunts) {self.jaunts = jaunts})
        });
      })
    },
  })
})();
