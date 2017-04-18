<%-- 
    Document   : testMap
    Created on : Apr 17, 2017, 6:00:03 PM
    Author     : Kyle Anderson
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--API KEY: AIzaSyBXyzB1ur8efWWkwuQVTlSbmZirV3ioOl4 -->
<html>
  <head>
    <title>Simple Map</title>
    <meta name="viewport" content="initial-scale=1.0">
    <meta charset="utf-8">
    <style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 100%;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
    </style>
  </head>
  <body>
      <h1>This is some stuff before the map</h1>
    <div id="map"></div>
    <script>
      var map;
      function initMap() {
        var central = {lat: 35.2157, lng: -97.0142};  
        var chicago = {lat: 41.8781, lng: -87.6298}
        var sanFrancisco = {lat: 37.7749, lng: -122.4194};
        var iowaCity = {lat: 41.6611, lng: -91.5302};
        var orlando = {lat: 28.5383, lng:-81.3792};
        var newYork = {lat: 40.7128, lng: -74.0059};
        map = new google.maps.Map(document.getElementById('map'), {
          center: central, //lat +N,-S lng +E,-W
          zoom: 5
        });
        var marker = new google.maps.Marker({
          position: chicago,
          map: map
        });
        
        marker = new google.maps.Marker({
          position: sanFrancisco,
          map: map
        });
        
        marker = new google.maps.Marker({
          position: iowaCity,
          map: map
        });
        
        marker = new google.maps.Marker({
          position: orlando,
          map: map
        });
        
        marker = new google.maps.Marker({
          position: newYork,
          map: map
        });
        
        var line = new google.maps.Polyline({
        path: [
            chicago, 
            orlando,
            newYork,
        ],
        strokeColor: "#FF0000",
        strokeOpacity: 1.0,
        strokeWeight: 5,
        geodesic: true, //flight path
        map: map
        });
        
      }
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBXyzB1ur8efWWkwuQVTlSbmZirV3ioOl4&callback=initMap"
    async defer></script>
    <h2>Test Text</h2>
  </body>
</html>