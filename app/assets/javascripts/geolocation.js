// if($('div').is('#current_locations_page')){
//   $(function(){
//     handler = Gmaps.build('Google');
//     handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
//       if(navigator.geolocation)
//         navigator.geolocation.getCurrentPosition(displayOnMap);
//         markers = handler.addMarkers(<%=raw @hash.to_json %>);
//         handler.bounds.extendWith(markers);
//         handler.fitMapToBounds();
//         // handler.getMap().setZoom(4);
//     });
//
//     function displayOnMap(position){
//       var selfMarker = handler.addMarker({
//         lat: position.coords.latitude,
//         lng: position.coords.longitude
//       });
//       // handler.map.centerOn(selfMarker);
//     };
//   });
// };


// var userId = document.getElementById("user_id").innerHTML;
// var x = document.getElementById("demo");
//
// function getLocation() {
//   currentLocation();
//   $.ajax({
//     type: "PATCH",
//     url: '/current_locations/'+userId,
//     dataType: "json",
//     success: function() {
//       console.log("Hi!");
//     }
//   });
// }
//
// function currentLocation() {
//     if (navigator.geolocation) {
//         var data = navigator.geolocation.getCurrentPosition(showPosition, showError);
//     } else {
//         x.innerHTML = "Geolocation is not supported by this browser.";
//     }
// }
//
// function showPosition(position) {
//     x.innerHTML = "Latitude: " + position.coords.latitude +
//     "<br>Longitude: " + position.coords.longitude;
// }
//
// function showError(error) {
//     switch(error.code) {
//         case error.PERMISSION_DENIED:
//             x.innerHTML = "User denied the request for Geolocation."
//             break;
//         case error.POSITION_UNAVAILABLE:
//             x.innerHTML = "Location information is unavailable."
//             break;
//         case error.TIMEOUT:
//             x.innerHTML = "The request to get user location timed out."
//             break;
//         case error.UNKNOWN_ERROR:
//             x.innerHTML = "An unknown error occurred."
//             break;
//     }
// }
