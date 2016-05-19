;(function () {
  "use strict"

  Vue.component("vue-jauntsearch", {
    template: "#search-jaunt-template",
    data: function() {
      return {
        jaunts_with_locations: {}
      }
    },

    ready: function() {
      var self = this
      self.jaunts_with_locations = gon.jaunts_with_locations

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
          }).then(function(searched_jaunts_with_locations) {self.jaunts_with_locations = searched_jaunts_with_locations})
        })
      })
    },

    methods: {
      clearSearch: function() {
        this.jaunts_with_locations = gon.jaunts_with_locations
      }
    }
  })
})();
