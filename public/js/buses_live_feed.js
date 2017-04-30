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
var database = firebase.database();
var ref, route, start, end, midLat, midLng, date, interval;


// Google Maps
var points = [];

function initMap() {
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 16,
    maxZoom: 19,
    minZoom: 10,
    center: {lat: 29.976650, lng: 30.948297}
  });

  $("input[name=date]").change(function(){
    date = $(this).val();
    if (date == "live"){
      date = new Date();
      var dd = date.getDate();
      var mm = date.getMonth()+1;
      var yyyy = date.getFullYear();
      if(dd<10) {
        dd='0'+dd
      }
      if(mm<10) {
        mm='0'+mm
      }
      date = dd + "/" + mm +"/" + yyyy;
    }
    interval = $('input[name=interval]:checked').val();

    if (route)
    {
      route.setMap(null);
      points = [];
    }
    ref = firebase.database().ref("live/"+$('#collapse > div > div:nth-child(2) > div > select').val());
    ref.on("value", function(snapshot) {
      for (var key in snapshot.val()) {
        var receivedDate = new Date(snapshot.val()[key]["timeStamp"]*1000);
        var dd = receivedDate.getDate();
        var mm = receivedDate.getMonth()+1;
        var yyyy = receivedDate.getFullYear();
        if(dd<10) {
          dd='0'+dd
        }
        if(mm<10) {
          mm='0'+mm
        }
        checkDate = dd + "/" + mm +"/" + yyyy;
        if(checkDate == date){
          var hours = receivedDate.getHours();
          var hours = (hours+24-2)%24;
          var checkInterval = 'am';
          if(hours>12)
          {
            checkInterval='pm';
          }
          if(checkInterval == interval){
            points.push({lat:snapshot.val()[key]["lat"], lng: snapshot.val()[key]["lng"]});
          }
        }
      }
      if (points.length > 0){
        route = new google.maps.Polyline({
          path: points,
          strokeColor: '#FF0000',
          strokeOpacity: 0.7,
          strokeWeight: 3
        });
        start = points[0];
        end = points[points.length-1];
        midLat = (start.lat + end.lat)/2;
        midLng = (start.lng + end.lng)/2;
        map.setCenter(new google.maps.LatLng(midLat, midLng));
        map.setZoom(11);
        route.setMap(map);
      }
      else{
        alert('No route found');
        route.setMap(null);
        points = [];

      }
    });
  });

  $('input[name=interval]').change(function(){
    date = $("input[name=date]").val();
    if (date == "live"){
      date = new Date();
      var dd = date.getDate();
      var mm = date.getMonth()+1;
      var yyyy = date.getFullYear();
      if(dd<10) {
        dd='0'+dd
      }
      if(mm<10) {
        mm='0'+mm
      }
      date = dd + "/" + mm +"/" + yyyy;
    }
    interval = $('input[name=interval]:checked').val();

    if (route)
    {
      route.setMap(null);
      points = [];
    }
    ref = firebase.database().ref("live/"+$('#collapse > div > div:nth-child(2) > div > select').val());
    ref.on("value", function(snapshot) {
      for (var key in snapshot.val()) {
        var receivedDate = new Date(snapshot.val()[key]["timeStamp"]*1000);
        var dd = receivedDate.getDate();
        var mm = receivedDate.getMonth()+1;
        var yyyy = receivedDate.getFullYear();
        if(dd<10) {
          dd='0'+dd
        }
        if(mm<10) {
          mm='0'+mm
        }
        checkDate = dd + "/" + mm +"/" + yyyy;
        if(checkDate == date){
          var hours = receivedDate.getHours();
          var hours = (hours+24-2)%24;
          var checkInterval = 'am';
          if(hours>12)
          {
            checkInterval='pm';
          }
          if(checkInterval == interval){
            points.push({lat:snapshot.val()[key]["lat"], lng: snapshot.val()[key]["lng"]});
          }
        }
      }
      if (points.length > 0){
        route = new google.maps.Polyline({
          path: points,
          strokeColor: '#FF0000',
          strokeOpacity: 0.7,
          strokeWeight: 3
        });
        start = points[0];
        end = points[points.length-1];
        midLat = (start.lat + end.lat)/2;
        midLng = (start.lng + end.lng)/2;
        map.setCenter(new google.maps.LatLng(midLat, midLng));
        map.setZoom(11);
        route.setMap(map);
      }
      else{
        alert('No route found');
        route.setMap(null);
        points = [];
        
      }
    });
  });
  $('#collapse > div > div:nth-child(2) > div > select').change(function(){
      $("input[name=date]").prop('disabled', false);
      $('input[name=interval]').prop('disabled', false);
      date = $("input[name=date]").val();
      if (date == "live"){
        date = new Date();
        var dd = date.getDate();
        var mm = date.getMonth()+1;
        var yyyy = date.getFullYear();
        if(dd<10) {
          dd='0'+dd
        }
        if(mm<10) {
          mm='0'+mm
        }
        date = dd + "/" + mm +"/" + yyyy;
      }
      interval = $('input[name=interval]:checked').val();
      if (route)
      {
        route.setMap(null);
        points = [];
      }
      points =[];
      ref = firebase.database().ref("live/"+$(this).val());
      ref.on("value", function(snapshot) {
        for (var key in snapshot.val()) {
          var receivedDate = new Date(snapshot.val()[key]["timeStamp"]*1000);
          var dd = receivedDate.getDate();
          var mm = receivedDate.getMonth()+1;
          var yyyy = receivedDate.getFullYear();
          if(dd<10) {
            dd='0'+dd
          }
          if(mm<10) {
            mm='0'+mm
          }
          checkDate = dd + "/" + mm +"/" + yyyy;
          if(checkDate == date){
            var hours = receivedDate.getHours();
            var hours = (hours+24-2)%24;
            var checkInterval = 'am';
            if(hours>12)
            {
              checkInterval='pm';
            }
            if(checkInterval == interval){
              points.push({lat:snapshot.val()[key]["lat"], lng: snapshot.val()[key]["lng"]});
            }
          }
        }
        if (points.length > 0){
          route = new google.maps.Polyline({
            path: points,
            strokeColor: '#FF0000',
            strokeOpacity: 0.7,
            strokeWeight: 3
          });
          start = points[0];
          end = points[points.length-1];
          midLat = (start.lat + end.lat)/2;
          midLng = (start.lng + end.lng)/2;
          map.setCenter(new google.maps.LatLng(midLat, midLng));
          map.setZoom(11);
          route.setMap(map);
        }
        else{
          alert('No route found');
          route.setMap(null);
          points = [];

        }
      });
  });
}


// Date picker
$(document).ready(function(){
  $('.datepicker').datepicker({
    format: "dd/mm/yyyy",
    forceParse: false,
    autoclose: true,
    todayHighlight: true,
    toggleActive: true
  });
});
