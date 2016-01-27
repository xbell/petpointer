var map;
var marker;
var markers = [];

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
  var setMarker = function(lat, lng) {
    if (marker !== undefined) {
      marker.setMap(null);
    }

    marker = new google.maps.Marker({
      position: {lat: lat, lng: lng},
      map: map
    });

    marker.addListener('click',function() {
      infowindow.open(map,marker);
    })

    var infowindow = new google.maps.InfoWindow({
      content: "info about the property dynamically passed in here",
      maxWidth: 400
    });
  };

  setMarker(lat, lng)

  var geocoder = new google.maps.Geocoder();

  $("#submit").click(function(){
    var address = $("#address").val();
      // need address variable each time for the click function to work
      geocoder.geocode({'address': address }, function(results) {
        var lat = results[0].geometry.location.lat();
        var lng = results[0].geometry.location.lng();
        // Do things with lat/lng here
        map.setCenter({lat: lat, lng:lng})
      // .setCenter will move the map
        setMarker(lat, lng);
      });
    });
  };
});
