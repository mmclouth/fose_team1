<%-- 
    Document   : searchResults
    Created on : Feb 14, 2017, 2:06:46 PM
    Author     : kenziemclouth
--%>
<%@page import="dbResources.FlightCombo"%>
<%@page import="dbResources.SearchResults"%>
<%@page import="dbResources.Search2"%>
<%@page import="java.util.Map"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="dbResources.Search"%>
<%
    String return_date;
    
    SearchResults returnResults = new SearchResults();
    int num_of_passengers;
    int first_class_remaining, economy_remaining, total;
    ArrayList<String> flight_ID_parameters = new ArrayList<String>();
    ArrayList<String> flight_IDs = new ArrayList<String>();
    ArrayList<ArrayList<String>> eachReturnPath = new ArrayList<ArrayList<String>>();
    
    String[] columnHeaders = {"Flight","Origin","Destination","Departure","Arrival"};
    String[] fields = {"num","origin_code","destination_code","departure_date","departure_time","arrival_date","arrival_time"};
    
    
    boolean return_flight = false;          //Used to determine if return trip was selected
    boolean selectingReturnFlight = false;  //Used to determine which set of flight results should be displayed (depart or return)
    int numOfFlights;
    
    
    Map<String, String[]> parameters = request.getParameterMap();
    
    if(session.getAttribute("has_return_flight") != null){
        if(session.getAttribute("has_return_flight").equals("true")){
            return_flight = true;
        } else {
            return_flight = false;
        }
    }
    
    if(session.getAttribute("selectingReturnFlight") != null){
        if(session.getAttribute("selectingReturnFlight").equals("true")){
            selectingReturnFlight = true;
        } else {
            selectingReturnFlight = false;
        }
    }
    
    //retrieve request parameters from search
    if (request.getParameter("origin") != null) 
    {
        session.setAttribute("origin_code", request.getParameter("origin"));
    }
    
    if (request.getParameter("destination") != null) 
    {
        session.setAttribute("destination_code", request.getParameter("destination"));
    } 
    if (request.getParameter("d_date") != null) 
    {
        session.setAttribute("departure_date", request.getParameter("d_date"));
    } 
    if (request.getParameter("r_date") != null && !request.getParameter("r_date").equals("")) 
    {
        session.setAttribute("return_date", request.getParameter("r_date")); 
        session.setAttribute("has_return_flight", "true");
    } 
    if (request.getParameter("num_of_passengers") != null && !request.getParameter("num_of_passengers").equals("")) 
    {
        num_of_passengers = Integer.parseInt(request.getParameter("num_of_passengers"));
        session.setAttribute("num_of_passengers", Integer.parseInt(request.getParameter("num_of_passengers")));
    } else {
        num_of_passengers = 1;
    }
    
    //If departing flight has been selected, get all flight IDs and set "depart_flight" session attribute to ArrayList of flight_IDs
    if(request.getParameter("flight_id1") != null){
        
        for(String parameterName : parameters.keySet()){
        
            //add flight_id parameter names to list
            if(parameterName.startsWith("flight_id")){
                flight_ID_parameters.add(parameterName);
            }
        }
        
        //get ID from request for each parameter name
        for(String parameter : flight_ID_parameters){
            if(request.getParameter(parameter) != null){
                flight_IDs.add(request.getParameter(parameter));
            }
        }
        
        //set session attribute to arrayList of flight_IDs that will be accessed in confirmBooking.jsp
        session.setAttribute("depart_flight", flight_IDs);
        
        //If the user did not specify a return flight
        if(!return_flight){
            
            //set return flight-related session attributes to false
            session.setAttribute("selectingReturnFlight", "false");
            session.setAttribute("has_return_flight", "false");
            
            //go to confirmBooking page
            response.sendRedirect("/IowaAir/confirmBooking.jsp");
            return;
        } else {
            
            //this variable will tell jsp later on to display return flight results
            session.setAttribute("selectingReturnFlight", "true");
            selectingReturnFlight = true;
        }
        
    }
    
    if(request.getParameter("sortParameter") != null){
        session.setAttribute("sortParameter", request.getParameter("sortParameter"));
    }
    
    
    //If return flight has been selected, get all flight IDs and set "return_flight" session attribute to ArrayList of flight_IDs
    if(request.getParameter("return_flight_id1") != null && selectingReturnFlight){
        
        selectingReturnFlight = true;
        for(String parameterName : parameters.keySet()){
        
            //add flight_id parameter names to list
            if(parameterName.startsWith("return_flight_id")){
                flight_ID_parameters.add(parameterName);
            }
        }
        
        //get ID from request for each parameter name
        for(String parameter : flight_ID_parameters){
            if(request.getParameter(parameter) != null){
                flight_IDs.add(request.getParameter(parameter));
            }
        }
        
        session.setAttribute("return_flight", flight_IDs);
        
        session.setAttribute("selectingReturnFlight", "false");
        session.setAttribute("has_return_flight", "false");
        
        response.sendRedirect("/IowaAir/confirmBooking.jsp");
        return;
    }

    //Parse date from date string
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    

    
    //if return flight was specified, parse date, create Search object, retrieve search results
    if(selectingReturnFlight){
        Date r_date = formatter.parse((String) session.getAttribute("return_date"));
        
        //Create Search object and then retrieve search results
        Search2 search = new Search2((String) session.getAttribute("destination_code"), (String) session.getAttribute("origin_code"), r_date);
        returnResults = search.getSearchResults();
        
        if(session.getAttribute("sortParameter") != null){
            returnResults.sortBy((String) session.getAttribute("sortParameter"), true);
        } else {
            returnResults.sortBy("departure_time", true);
        }
                String destination = null;
                int index = 0;
                for(FlightCombo flightCombo : returnResults.getFlightCombos()) {
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
            <h1>Search Results Page</h1>

            <form action="searchResults.jsp">
                <select name="sortParameter">
                    <option value="price">Price</option>
                    <option value="departure_time">Departure Time</option>
                    <option value="arrival_time">Arrival Time</option>
                    <option value="duration">Duration</option>
                </select>
                <input type="submit" value="Sort">
            </form>
        
        <% if(!selectingReturnFlight){ %>
        
            <h2>Select Flight to <%=session.getAttribute("destination_code")%></h2>
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
            
            if(session.getAttribute("departure_date") != null){
                Date d_date = formatter.parse((String) session.getAttribute("departure_date"));
                
                //Create Search object and then retrieve search results
                Search2 search = new Search2((String) session.getAttribute("origin_code"),(String) session.getAttribute("destination_code"), d_date);
                SearchResults searchResults = search.getSearchResults();
                
                if(session.getAttribute("sortParameter") != null){
                    searchResults.sortBy((String) session.getAttribute("sortParameter"), true);
                } else {
                    searchResults.sortBy("departure_time", true);
                }
                
                //Used to store flight information for each map
                //Example layout is like this
                //
                //               ORD
                //                ^
                //                |
                //               SFO                ORD
                //                ^                  ^
                //                |                  |
                //      ORD      ATL       ORD      SFO
                //       ^        ^         ^        ^
                //       |        |         |        |
 //OUTER LIST:          IFC - >  IFC  - >  IFC  - > IFC
                ArrayList<ArrayList<String>> eachFlightPath = new ArrayList<ArrayList<String>>();
                String destination = null;
                int index = 0;
                for(FlightCombo flightCombo : searchResults.getFlightCombos()) {
                    eachFlightPath.add(new ArrayList<String>());
                    for(HashMap<String,String> flight : flightCombo.getFlights()) {
                        eachFlightPath.get(index).add(flight.get("origin_code"));
                        destination = flight.get("destination_code");
                    }
                    //wait until more than one index
                    if(index > 0) {
                        eachFlightPath.get(index - 1).add(destination);
                        eachFlightPath.get(index - 1).add("NO MORE"); //signifies end of list
                    }
                    ++index;
                }
                if(index != 0) {
                    eachFlightPath.get(index - 1).add(destination); //tack on for last flight
                    eachFlightPath.get(index - 1).add("NO MORE"); //signifies end of list
                }
            
            
            //iterate through each flight combo
            for(FlightCombo flightCombo : searchResults.getFlightCombos()){
                numOfFlights = flightCombo.getNumberOfFlights();
   
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

                    first_class_remaining = Integer.parseInt(flight.get("first_class_remaining"));
                    economy_remaining = Integer.parseInt(flight.get("economy_remaining"));
                    
                    total = first_class_remaining + economy_remaining;
     
        %>
                <tr>
        <%      
                for(String field : fields){ %>
                <td><%= flight.get(field) %></td>
        <%          }   %>
                    <%   if(first){       %>
                    <td rowspan="<%=numOfFlights%>"><%= flightCombo.getDuration() %></td>
                    <td rowspan="<%=numOfFlights%>"><%= flightCombo.getPrice() %></td>
                    <td rowspan="<%=numOfFlights%>">
                        <form action="searchResults.jsp">
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
%>
                </table>
<%} %>

<form action="testMap.jsp">
    <% int counter = 0;
       for(ArrayList<String> cluster : eachFlightPath) {
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

          <%  } %>
        
        </div>
            
        <% }  else if(selectingReturnFlight){      %>    
          
                    
            <h2>Select Return Flight <%=session.getAttribute("origin_code")%></h2>
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
            
            if(session.getAttribute("departure_date") != null){
                Date d_date = formatter.parse((String) session.getAttribute("departure_date"));
                
                //Create Search object and then retrieve search results
                Search2 search = new Search2((String) session.getAttribute("origin_code"),(String) session.getAttribute("destination_code"), d_date);
                SearchResults searchResults = search.getSearchResults();
                
                if(session.getAttribute("sortParameter") != null){
                    searchResults.sortBy((String) session.getAttribute("sortParameter"), true);
                } else {
                    searchResults.sortBy("departure_time", true);
                }
            
            
            //iterate through each flight combo
            for(FlightCombo flightCombo : returnResults.getFlightCombos()){
                numOfFlights = flightCombo.getNumberOfFlights();
   
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

                    first_class_remaining = Integer.parseInt(flight.get("first_class_remaining"));
                    economy_remaining = Integer.parseInt(flight.get("economy_remaining"));
                    
                    total = first_class_remaining + economy_remaining;
     
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
                        <form action="searchResults.jsp">
        <%                    
                            int counter = 1;
                            for(HashMap<String,String> flightForForm : flightCombo.getFlights()){ 
        %>                    
                            <input type="hidden" name="return_flight_id<%=counter%>" value="<%=flightForForm.get("id") %>">
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
%>
                </table>
<%} %>
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
        <% } %>
            
        </div>

        <% }    %>  
        <div class="clear"></div> 
    </body>
</html>
