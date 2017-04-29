<%-- 
    Document   : testMap
    Created on : Apr 17, 2017, 6:00:03 PM
    Author     : Kyle Anderson
--%>

<%@page import="dbResources.JavaToJavascript"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--API KEY: AIzaSyBXyzB1ur8efWWkwuQVTlSbmZirV3ioOl4 -->


<%
    JavaToJavascript converter = new JavaToJavascript();
    int totalCount = Integer.parseInt(request.getParameter("totalCount"));
    String[] cities = new String[totalCount];
    for(int i = 0; i < totalCount; ++i) {
        String temp = "flightCluster" + Integer.toString(i);
        cities[i] = request.getParameter(temp);
    }
    
    
    
%>
<html>
  <head>
        <title>Iowa Air</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
      
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
      <% for(String s : cities) { %>
      <h4><%= s %></h4>
      <%  }
      %>
    <div id="map"></div>
    <script>
      var map;
      var myArray = <%= converter.toJavascriptArray(cities) %>;
      
      function contains(a, obj) {
        var i = a.length;
        while (i--) {
           if (a[i] === obj) {
               return true;
           }
        }
        return false;
      }
      
      function initMap() {
        var colors = [
            "#FF0000",
            "#0000FF",
            "#00FF00",
            "#FFFF00",
            "#00FFFF",
            "#FF8000",
            "#8000FF",
            "#00FFBF",
            "#FF00BF",
            "#BFFF00",
            "#FFBF00"
        ];  
        var central = {lat: 35.2157, lng: -97.0142};  
        var chicago = {lat: 41.8781, lng: -87.6298}
        var sanFrancisco = {lat: 37.7749, lng: -122.4194};
        var cedarRapids = {lat: 41.9779, lng: -91.6656};
        var atlanta = {lat: 33.7490, lng:-84.3880};
        var newYork = {lat: 40.7128, lng: -74.0059};
        map = new google.maps.Map(document.getElementById('map'), {
          center: central, //lat +N,-S lng +E,-W
          zoom: 5
        });
        if(contains(myArray, "ORD")) {
            var marker = new google.maps.Marker({
              position: chicago,
              map: map

            });
        }
        
        if(contains(myArray, "SFO")) {
            marker = new google.maps.Marker({
              position: sanFrancisco,
              map: map
            });
        }
        
        if(contains(myArray, "IFC")) {
            marker = new google.maps.Marker({
              position: cedarRapids,
              map: map
            });
        }
        
        if(contains(myArray, "ATL")) {
            marker = new google.maps.Marker({
              position: atlanta,
              map: map
            });
        }
        
        if(contains(myArray, "JFK")) {
            marker = new google.maps.Marker({
              position: newYork,
              map: map
            });
        }
        
        var count = 1;
        var flightPath = [];
      for (var i = 0; i < myArray.length; ++i) {
          if(myArray[i] === "IFC") {
              flightPath.push(cedarRapids);
          } else if(myArray[i] === "ATL") {
              flightPath.push(atlanta);
          } else if(myArray[i] === "SFO") {
              flightPath.push(sanFrancisco);
          } else if(myArray[i] === "ORD") {
              flightPath.push(chicago);
          } else if(myArray[i] === "JFK") {
              flightPath.push(newYork);
          }
          else {
                var line = new google.maps.Polyline({
                path: flightPath,
                strokeColor: colors[count],
                strokeOpacity: 1.0,
                strokeWeight: 5,
                geodesic: true, //curved flight path
                map: map
                });
                flightPath.length = 0;
                count++;
                if(count === colors.length) {
                    count = 0;
                }
          }
      }
        
      }
      
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBXyzB1ur8efWWkwuQVTlSbmZirV3ioOl4&callback=initMap"
    async defer></script>
    
    <h2>Test Text</h2>
    
  </body>
</html>