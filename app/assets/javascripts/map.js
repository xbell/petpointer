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
  };

    geocoder = new google.maps.Geocoder();
    geocoder.geocode({'address': "New York City"}, function(results, status) {
    var lat = results[0].geometry.location.lat();
    var lng = results[0].geometry.location.lng();
    // Do things with lat/lng here
  });




});
