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
        map = new google.maps.Map(document.getElementById('map'), {
          center: {lat: 35.0000, lng: -95.0000}, //these are coordinates for whole states on zoom 5
          zoom: 5
        });
      }
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBXyzB1ur8efWWkwuQVTlSbmZirV3ioOl4&callback=initMap"
    async defer></script>
    <h2>This is some smaller stuff after the map</h2>
  </body>
</html>