var map;

$(function() {

  if (navigator === undefined) {
    initializeMap(-34.1, 150.6);
  } else {
    navigator.geolocation.getCurrentPosition(function(position) {
      var lat = position.coords.latitude;
      var lng = position.coords.longitude;
      initializeMap(lat, lng);
    });
  }
  var initializeMap = function(lat, lng) {
    var mapDiv = $("#map")[0];
    var map = new google.maps.Map(mapDiv, {
      center: {lat: lat, lng: lng},
      zoom: 13
    });

    var geocoder = new google.maps.Geocoder();

    $("#submit").click(function(){
      var address = $("#address").val();
        // need address variable each time for the click function to work
        geocoder.geocode({'address': address }, function(results) {
          console.log(results);
          var lat = results[0].geometry.location.lat();
          var lng = results[0].geometry.location.lng();
          // Do things with lat/lng here
          map.setCenter({lat: lat, lng:lng})
        // .setCenter will move the map
        });
      });

    };

 });
