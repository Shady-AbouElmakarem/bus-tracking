 // Initialize Firebase
var config = {
  apiKey: "AIzaSyA3zFJYZMycE1VeKJjxqDYTFZgxfMTwpM8",
  authDomain: "o6u-bus-tracker-cf9ed.firebaseapp.com",
  databaseURL: "https://o6u-bus-tracker-cf9ed.firebaseio.com",
  projectId: "o6u-bus-tracker-cf9ed",
  storageBucket: "o6u-bus-tracker-cf9ed.appspot.com",
  messagingSenderId: "652433985052"
};

firebase.initializeApp(config);
// Initialized variables
var database = firebase.database(),
    user = JSON.parse($("#user").val()),
    pickUpLocationLat = user.pickUpLocation.lat,
    pickUpLocationLng = user.pickUpLocation.lng,
    bus = user.bus,
    busLocationRef = firebase.database().ref("live/" + bus),
    busLat,
    busLng,
    start,
    end,
    eta,
    distance,
    pickUpLocationImage,
    busLocationImage,
    startMarker,
    endMarker;


// Google Map
window.initMap = function(){
  var map = new google.maps.Map(document.getElementById('map'), {
    maxZoom: 19,
    minZoom: 10,
  });
  //Custom Marker Image
  pickUpLocationImage = new google.maps.MarkerImage('/images/pickupLocation.png',
    new google.maps.Size(32, 32),
    new google.maps.Point(0,0)
  );
  busLocationImage = new google.maps.MarkerImage('/images/busLocation.png',
    new google.maps.Size(32, 32),
    new google.maps.Point(0,0)
    );
  var directionsService = new google.maps.DirectionsService;
  var directionsDisplay = new google.maps.DirectionsRenderer({suppressMarkers: true});

  busLocationRef.on("value", function(snapshot) {
    if(endMarker){
      endMarker.setMap(null);
    }
    var timeStamp = 0;
    busLat = 0;
    busLng = 0;
    for (var point in snapshot.val()) {
      if(snapshot.val()[point].timeStamp >= timeStamp)
      {
      timeStamp = snapshot.val()[point].timeStamp;
      busLat = snapshot.val()[point].lat;
      busLng = snapshot.val()[point].lng;
      }
    }
    start = {lat: parseFloat(pickUpLocationLat),lng: parseFloat(pickUpLocationLng)};
    end = {lat:busLat,lng:busLng};
    directionsDisplay.setMap(map);
    calculateAndDisplayRoute(directionsService, directionsDisplay, start, end, map);
  });
}

function calculateAndDisplayRoute(directionsService, directionsDisplay, start, end, map) {
  directionsService.route({
    origin: start,
    destination: end,
    travelMode: 'DRIVING',
    unitSystem: google.maps.UnitSystem.METRIC
  }, function(response, status) {
    if (status === 'OK') {
      directionsDisplay.setDirections(response);
      startMarker = new google.maps.Marker({
        position: response.routes[0].legs[0].start_location,
        title: "Pickup Location Location",
        icon: pickUpLocationImage,
      });
      endMarker = new google.maps.Marker({
        position: response.routes[0].legs[0].end_location,
        title: "Bus Location",
        icon: busLocationImage,
      });
      startMarker.setMap(map);
      endMarker.setMap(map);

      eta = response.routes[0].legs[0].duration.text;
      distance = response.routes[0].legs[0].distance.text;
      $('#arrival').text(distance +" ("+ eta+")");
    } else {
      window.alert('Directions request failed due to ' + status);
    }
  });
}
