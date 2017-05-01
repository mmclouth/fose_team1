<%-- 
    Document   : searchResultsMultiCity
    Created on : Apr 6, 2017, 12:26:19 PM
    Author     : kenziemclouth
--%>

<%@page import="java.util.HashMap"%>
<%@page import="dbResources.FlightCombo"%>
<%@page import="dbResources.Search2"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dbResources.SearchResults"%>
<%@page import="dbResources.Search"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%
    String[] fields = {"num","origin_code","destination_code","departure_date","departure_time","arrival_date","arrival_time"};
    
    
    ArrayList<String> origins = new ArrayList<String>();
    ArrayList<String> destinations = new ArrayList<String>();
    ArrayList<String> dates = new ArrayList<String>();
    
    ArrayList<String> flightIDs = new ArrayList<String>();
    
    int numOfPassengers = 1;
    int numberOfFlights = 0;
    
    Map<String, String[]> parameters = request.getParameterMap();
    
    if(session.getAttribute("flight_info_retrieved") == null){
    
    for(String parameterName : parameters.keySet()){
        
        if(parameterName.startsWith("multiFlightOrigin")){
            if(request.getParameter(parameterName) != null  && !request.getParameter(parameterName).equals("null")){
                origins.add(request.getParameter(parameterName));
            }
        }
        
        if(parameterName.startsWith("multiFlightDestination")){
            if(request.getParameter(parameterName) != null && !request.getParameter(parameterName).equals("null")){
                destinations.add(request.getParameter(parameterName));
            }
        }
                
        if(parameterName.startsWith("multiFlightDepart")){
            if(request.getParameter(parameterName) != null && !request.getParameter(parameterName).equals("null")){
                dates.add(request.getParameter(parameterName));
            }
        }
    }
    
    session.setAttribute("origins", origins);
    session.setAttribute("destinations", destinations);
    session.setAttribute("dates", dates);
    
    if(request.getParameter("num_of_passengers") != null){
        session.setAttribute("num_of_passengers", Integer.parseInt(request.getParameter("num_of_passengers")));
    }
    
    }
    
    origins = (ArrayList<String>) session.getAttribute("origins");
    destinations = (ArrayList<String>) session.getAttribute("destinations");
    dates = (ArrayList<String>) session.getAttribute("dates");
    
    numberOfFlights = origins.size();
    
    if(session.getAttribute("flight_index") == null){
        session.setAttribute("flight_index",  "0");
        session.setAttribute("flight_info_retrieved", "true");
    } else {
            for (String parameterName : parameters.keySet()) {

                if (request.getParameter(parameterName) != null) {
                    if (parameterName.startsWith("flight_id")) {
                        flightIDs.add(request.getParameter(parameterName));
                    }
                }
            }
            session.setAttribute("flight" + (String) session.getAttribute("flight_index"), flightIDs);
        
            if (Integer.parseInt((String) session.getAttribute("flight_index")) < numberOfFlights - 1) {
                int holder = Integer.parseInt((String) session.getAttribute("flight_index")) + 1;
                session.setAttribute("flight_index", Integer.toString(holder));
            } else {
                response.sendRedirect("/IowaAir/confirmBookingMultiCity.jsp");
                return;
            }
        }
    
    int flightIndex = Integer.parseInt((String) session.getAttribute("flight_index"));
    
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    
    Search2 search = new Search2(origins.get(flightIndex), destinations.get(flightIndex), formatter.parse(dates.get(flightIndex)));
    SearchResults results = search.getSearchResults();
    
    String destination = null;
                int index = 0;
                ArrayList<ArrayList<String>> eachReturnPath = new ArrayList<ArrayList<String>>();
                for(FlightCombo flightCombo : results.getFlightCombos()) {
                    eachReturnPath.add(new ArrayList<String>());
                    for(HashMap<String,String> flight : flightCombo.getFlights()) {
                        eachReturnPath.get(index).add(flight.get("origin_code"));
                        destination = flight.get("destination_code");
                    }
                    //wait until more than one index
                    if(index > 0) {
                        eachReturnPath.get(index - 1).add(destination);
                        eachReturnPath.get(index - 1).add("NO MORE"); //signifies end of list
                    }
                    ++index;
                }
                if(index != 0) {
                    eachReturnPath.get(index - 1).add(destination); //tack on for last flight
                    eachReturnPath.get(index - 1).add("NO MORE"); //signifies end of list
                }



%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Iowa Air: Search Results</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/css?family=Catamaran" rel="stylesheet">
        <link rel="stylesheet" href="style.css">
    </head>
    <body>
        
        <% if(session.getAttribute("userID") == null){ %>
        
        <div class="title-top">
            
            <a class="title" href="index.html"><h1>Iowa Air</h1></a>
            <a class="links" href="logIn.jsp" ><h2>Log In</h2></a>
            <h3>|</h3>
            <a class="links" href="signUp.jsp" ><h2>Sign Up</h2></a>
        </div>
        
        <% } else { %>
        
        <% if (session.getAttribute("validation_status") != null && session.getAttribute("validation_status").equals("0")) { %>
            <div class="validate_account_bar">
                <h10>  You have not validated your account yet.  <a href="signUpConfirmation.jsp">Click here</a> to enter your confirmation code.</h10>
            </div>
        <% } %>
        
        <div class="title-top">
            <a class="title" href="<%= session.getAttribute("homePage") %>"><h1>Iowa Air</h1></a>
            <a class="links" href="<%=request.getContextPath()%>/LogoutServlet"><h2>Log Out</h2></a>
            <h3>|</h3>
            <a class="links" href="userProfile.jsp" ><h4><%= session.getAttribute("userFirstName") %>'s Profile</h4></a>
        </div>
        
        <% } %>
        
        <div class="middle">
            <h2>Select Flight <%=Integer.parseInt((String)session.getAttribute("flight_index")) + 1%></h2>
        </div>
        
        <div class="search-results-table">
            
            <table>
                <tr>
                    <th>Flight</th>
                    <th>Origin</th>
                    <th>Destination</th>
                    <th colspan="2">Departure</th>
                    <th colspan="2">Arrival</th>
                    <th>Duration</th>
                    <th>Price</th>
                </tr>
                <tr>
                    <td> </td>
                    <td> </td>
                    <td> </td>
                    <td> </td>
                    <td> </td>
                    <td> </td>
                    <td> </td>
                    <td> </td>
                    <td> </td>
                </tr>
            </table>    
        <%
            
            //iterate through each flight combo
            for(FlightCombo flightCombo : results.getFlightCombos()){
                int numOfFlights = flightCombo.getNumberOfFlights();
   
            boolean first = true;
            int rowCounter = 1;   %>
            
            <table id="inner">
            
                <tr>
                    <th> </th>
                    <th> </th>
                    <th> </th>
                    <th colspan="2"> </th>
                    <th colspan="2"> </th>                  
                    <th> </th>
                    <th> </th>
                    
                </tr>
            
            <%
            for(HashMap<String,String> flight : flightCombo.getFlights()){     

                    int first_class_remaining = Integer.parseInt(flight.get("first_class_remaining"));
                    int economy_remaining = Integer.parseInt(flight.get("economy_remaining"));
                    
                    int total = first_class_remaining + economy_remaining;
     
        %>
                <tr>
        <%      
                for(String field : fields){ %>
                    <td><%= flight.get(field) %> </td>
        <%          }   %>
                    <%   if(first){       %>
                    <td rowspan="<%=numOfFlights%>"><%= flightCombo.getDuration() %></td>
                    <td rowspan="<%=numOfFlights%>"><%= flightCombo.getPrice() %></td>
                    <td rowspan="<%=numOfFlights%>">
                        <form action="searchResultsMultiCity.jsp">
        <%                    
                            int counter = 1;
                            for(HashMap<String,String> flightForForm : flightCombo.getFlights()){ 
        %>                    
                            <input type="hidden" name="flight_id<%=counter%>" value="<%=flightForForm.get("id") %>">
        <%                      counter++;
                            }
        %>                    
                            <input type="submit" value="Select" >
                        </form>
                    </td>
                    <% first = false;
                    } %>
                </tr>
        <%
            
                    rowCounter++;
                }

            }
%>
                </table>
                
                <form action="testMap.jsp">
    <% int counter = 0;
       for(ArrayList<String> cluster : eachReturnPath) {
          int i = 0;
          while(i < cluster.size()) {
    %>
    <input type="hidden" name="flightCluster<%=counter++%>" value="<%=cluster.get(i++)%>">
    <%
          }

       }
    %>
    <input type="hidden" name="totalCount" value="<%=counter%>">
    <input type="submit" value="View Map" >
</form>
            
        </div>


    </body>
</html>
