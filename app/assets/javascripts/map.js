var map;
var marker;
var markers = [];
var geocoder;

$(function() {
  // saves and deletes favorites but doesn't remember if address has been saved yet
  // need to replace address with Zillow Id
  $("#rating-input-1-1").on("change", function() {
    if ($(this).is(':checked')) {
      // get current marker position
      geocoder.geocode({"location": marker.position}, function(response) {
        response[0].formatted_address;
        // ajax request to my server to save address into database
        // $.post("/map", {zillow_id: response[0].formatted_address});
        $.post("/map", {zillow_id: "48712906"});
      });
    } else {
      geocoder.geocode({"location": marker.position}, function(response) {
        response[0].formatted_address;
        $.ajax({
          url: "/map",
          type: "DELETE",
          // data: {zillow_id: response[0].formatted_address}
          data: {zillow_id: "48712906"}
        });
      });
    }
  });

  $('.expander-trigger').click(function() {
    $(this).toggleClass("expander-hidden");
  });
  // javascript for expander
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

  // begin logic for displaying map markers
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
  // end logic for displaying map markers

  geocoder = new google.maps.Geocoder();

  $("#map-search").submit(function(event) {
    event.preventDefault();
    var address = $("#address").val();

      // need address variable each time for the click function to work
      geocoder.geocode({'address': address }, function(results) {
        var lat = results[0].geometry.location.lat();
        var lng = results[0].geometry.location.lng();
        // setCenter will move the map
        map.setCenter({lat: lat, lng: lng});
        // setMarker resets marker to new map location
        setMarker(lat, lng);
      });

      // AJAX
      $.get("/yelp", function(data) {
        $("#ajax-response").html("My shizz ipsizzle pimpin' fizzle amet, shizzle my nizzle crocodizzle adipiscing elit. Nullam sapizzle velit, izzle volutpizzle, suscipit quizzle, gravida vel, dang. Pellentesque you son of a bizzle fo shizzle. Break yo neck, yall erizzle. Phat izzle dolor dapibizzle fo tempus fo shizzle. Maurizzle pellentesque nibh fo shizzle crunk. That's the shizzle izzle fo shizzle my nizzle. Pellentesque funky fresh crazy pot. In ass that's the shizzle platea dictumst. Donec sheezy. Fo shizzle mah nizzle fo rizzle, mah home g-dizzle bizzle urna, pretium the bizzle, ghetto ac, eleifend daahng dawg, nunc. Fo shizzle suscipit. Fo shizzle my nizzle mammasay mammasa mamma oo sa velit sizzle purus.");
      });
      // keeps star checked or not
      $.get("/favorites/48712906", function(data, status) {

        console.log(status);
        // if 200 then true
        if(status === "success") {
          // alert("success");
          $("#rating-input-1-1").prop("checked", true);
          // $("#rating-input-1-1").html("checked");
        // if 404 then false
        } else {
          // alert("fail");
          $("#rating-input-1-1").prop("checked", false);
          // $("#rating-input-1-1").html("unchecked");
        }
      });
    });

    // grab address from search bar on homepage
    // display that address on map page
    var addressInput = $("#address").val();
    if(addressInput !== "") {
      $("#map-search").submit();
    }
  };
});
