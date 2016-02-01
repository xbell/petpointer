
// javascript for expander
$(document).ready(function() {
  $('.expander-trigger').click(function(){
    $(this).toggleClass("expander-hidden");
  });
});

// javascript for rest of page
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
    });

    var infowindow = new google.maps.InfoWindow({
      content: "info about the property dynamically passed in here",
      maxWidth: 400
    });
  };



  setMarker(lat, lng);

  var geocoder = new google.maps.Geocoder();
  $("#map-search").submit(function(event){
    event.preventDefault();
    var address = $("#address").val();
      // need address variable each time for the click function to work
      geocoder.geocode({'address': address }, function(results) {
        var lat = results[0].geometry.location.lat();
        var lng = results[0].geometry.location.lng();
        // Do things with lat/lng here
        map.setCenter({lat: lat, lng:lng});
      // .setCenter will move the map
        setMarker(lat, lng);
      });
      $.get("/yelp", function(data) {
        $("#ajax-response").html("My shizz ipsizzle pimpin' fizzle amet, shizzle my nizzle crocodizzle adipiscing elit. Nullam sapizzle velit, izzle volutpizzle, suscipit quizzle, gravida vel, dang. Pellentesque you son of a bizzle fo shizzle. Break yo neck, yall erizzle. Phat izzle dolor dapibizzle fo tempus fo shizzle. Maurizzle pellentesque nibh fo shizzle crunk. That's the shizzle izzle fo shizzle my nizzle. Pellentesque funky fresh crazy pot. In ass that's the shizzle platea dictumst. Donec sheezy. Fo shizzle mah nizzle fo rizzle, mah home g-dizzle bizzle urna, pretium the bizzle, ghetto ac, eleifend daahng dawg, nunc. Fo shizzle suscipit. Fo shizzle my nizzle mammasay mammasa mamma oo sa velit sizzle purus.");
      });
    });
    var addressInput = $("#address").val();
    if(addressInput !== "") {
      $("#map-search").submit();
    }
  };
});
