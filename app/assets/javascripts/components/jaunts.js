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

    methods: {
      addJaunt: function() {
        var self = this
        console.log(self)
      }
    }
  })
})();
