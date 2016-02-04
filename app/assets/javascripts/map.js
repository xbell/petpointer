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
  // #map-search

  $("#map-search").submit(function(event) {
    event.preventDefault();
    var address = $("#address").val();
    // str variable is used to dynamically search yelp based on address input; it is
    // passed into the AJAX method below.
    var str = ["/yelp/",address].join("");

      // need address variable each time for the click function to work
      geocoder.geocode({'address': address }, function(results) {
        var lat = results[0].geometry.location.lat();
        var lng = results[0].geometry.location.lng();


        // CODE FOR ZIPCODE Variable this is breaking thw code
        for(var i=0; i < results[0].address_components.length; i++)
        {
          var component = results[0].address_components[i];
          if(component.types[0] == "postal_code")
          {
          console.log(component.long_name);
          }
        }
        //
        // Code For Street Variable
        // for(var i=0; i < results[0].address_components.length; i++)
        // {
        //   var street= results[0].address_components[i];
        //   if(street.types[0] == "street_address")
        //   {
        //   console.log(street.long_name);
        //
        //   }
        // }
        // setCenter will move the map
        map.setCenter({lat: lat, lng: lng});
        // setMarker resets marker to new map location
        setMarker(lat, lng);
      });

      // AJAX FOR YELP
      $.get(str, function(response) {
        // add scores for each yelp category:
        $("#parks-score").html(response.parks_score);
        $("#vets-score").html(response.vets_score);
        $("#pet-services-score").html(response.total_pet_services_score);

        // BEGIN list top property matches within each YELP category:
        var parks = response.park_names
        for (i = 0; i < parks.length; i++) {
          $("#parks").append(
            $('<li>').append(parks[i])
          );
        };

        var vets = response.vet_names
        for (i = 0; i < vets.length; i++) {
          $("#vets").append(
            $('<li>').append(vets[i])
          );
        };

        var pet_services = response.pet_services_names
        for (i = 0; i < pet_services.length; i++) {
          $("#pet_services").append(
            $('<li>').append(pet_services[i])
          );
        };
        // END list top property matches within each YELP category:

      });

      // AJAX FOR ZILLOW – COMPLETE ON SEPARATE BRANCH
      var zillowstr = ["/zillow/", address].join("");

      $.get( zillowstr, function(response) {

      });
      // keeps star checked or not
      if ($("#rating-input-1-1").length) {
        $.get("/favorites/48712906", function(data, status) {
          // console.log(status);
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
      }


      // AJAX FOR ZILLOW – COMPLETE ON SEPARATE BRANCH
      // $.get("/zillow", function(response) {
      //   $("#sqft-score").html(response._______)
      // });
    });

    // grab address from search bar on homepage
    // display that address on map page
    var addressInput = $("#address").val();
    if(addressInput !== "") {
      $("#map-search").submit();
    }
  };
});
