<%-- 
    Document   : searchResults
    Created on : Feb 14, 2017, 2:06:46 PM
    Author     : kenziemclouth
--%>
<%@page import="java.util.Map"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="dbResources.Search"%>
<%
    String origin_code, destination_code, departure_date = null, return_date;
    boolean return_flight = false;
    ArrayList<ArrayList<HashMap<String,String>>> returnResults = new ArrayList<ArrayList<HashMap<String,String>>>();
    int num_of_passengers;
    int first_class_remaining, economy_remaining, total;
    ArrayList<String> flight_ID_parameters = new ArrayList<String>();
    ArrayList<String> flight_IDs = new ArrayList<String>();
    
    String[] columnHeaders = {"Flight","Origin","Destination","Departure","Time","Arrival","Time"};
    String[] fields = {"num","origin_code","destination_code","departure_date","departure_time","arrival_date","arrival_time"};
    
    boolean selectingReturnFlight = false;
    int numOfFlights;
    
    
    Map<String, String[]> parameters = request.getParameterMap();
    
    if(session.getAttribute("has_return_flight") != null){
        if(session.getAttribute("has_return_flight").equals("true")){
            return_flight = true;
        } else {
            return_flight = false;
        }
    }
    
    //retrieve request parameters from search
    if (request.getParameter("origin") != null) 
    {
        origin_code = request.getParameter("origin");
        session.setAttribute("origin_code", origin_code);
    } else {
        origin_code = "n/a";
    }
    
    if (request.getParameter("destination") != null) 
    {
        destination_code = request.getParameter("destination");
        session.setAttribute("destination_code", destination_code);
    } else {
        destination_code = "n/a";
    }
    
    if (request.getParameter("d_date") != null) 
    {
        departure_date = request.getParameter("d_date");
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
    
    
    if(request.getParameter("flight_id1") != null){
        
        for(String parameterName : parameters.keySet()){
        
            //add flight_id parameter names to list
            if(parameterName.startsWith("flight_id")){
                flight_ID_parameters.add(parameterName);
            }
        }
        
        for(String parameter : flight_ID_parameters){
            if(request.getParameter(parameter) != null){
                flight_IDs.add(request.getParameter(parameter));
            }
        }
        
        
        session.setAttribute("depart_flight", flight_IDs);
        
        if(!return_flight){
            
            session.setAttribute("selectingReturnFlight", "false");
            session.setAttribute("has_return_flight", "false");
            
            response.sendRedirect("/IowaAir/confirmBooking.jsp");
            return;
        } else {
            session.setAttribute("selectingReturnFlight", "true");
            selectingReturnFlight = true;
        }
        
    }
    
    if(request.getParameter("return_flight_id1") != null && session.getAttribute("selectingReturnFlight").equals("true")){
        
        selectingReturnFlight = true;
        for(String parameterName : parameters.keySet()){
        
            //add flight_id parameter names to list
            if(parameterName.startsWith("return_flight_id")){
                flight_ID_parameters.add(parameterName);
            }
        }
        
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
    
    
    //Create Search object and then retrieve search results
    //Search search = new Search(origin_code, destination_code, d_date);
    //ArrayList<ArrayList<HashMap<String,String>>> searchResults = search.getSearchResults2();
    
    //if return flight was specified, parse date, create Search object, retrieve search results
    if(selectingReturnFlight){
        Date r_date = formatter.parse((String) session.getAttribute("return_date"));
        origin_code = (String) session.getAttribute("origin_code");
        destination_code = (String) session.getAttribute("destination_code");
        Search search = new Search(destination_code, origin_code, r_date);
        returnResults = search.getSearchResults2();
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

        
        
        <% if(!selectingReturnFlight){ %>
        
            <h2>Select Flight to <%=session.getAttribute("destination_code")%></h2>
        </div>
        
        <div class="employee-table">
            
            <table>
        
        <%
            
            if(departure_date != null){
                Date d_date = formatter.parse(departure_date);
                Search search = new Search(origin_code, destination_code, d_date);
                ArrayList<ArrayList<HashMap<String,String>>> searchResults = search.getSearchResults2();
            
            
            //iterate through each flight combo
            for(ArrayList<HashMap<String,String>> result : searchResults){
                
        %>
                <tr>

        <%      for(String field : columnHeaders){                     //print out table headers for each combo to separate options%>            
                    
                    <th><%=field%></th>
        
        <%            
                }
                numOfFlights = result.size();

                //create form that has hidden fields for each flight ID in current combo.  Form directs to confirmBooking.jsp
        %>
                    <th>Seats Left</th>
                    <th rowspan="<%=numOfFlights + 1%>"> 
                        <form action="searchResults.jsp">
        <%                    
                            int counter = 1;
                            for(HashMap<String,String> flight : result){ 
        %>                    
                            <input type="hidden" name="flight_id<%=counter%>" value="<%=flight.get("id") %>">
        <%                      counter++;
                            }
        %>                    
                            <input type="submit" value="Select" >
                        </form>
                    </th>
                </tr>
        <%      for(HashMap<String,String> flight : result){     

                    first_class_remaining = Integer.parseInt(flight.get("first_class_remaining"));
                    economy_remaining = Integer.parseInt(flight.get("economy_remaining"));
                    
                    total = first_class_remaining + economy_remaining;
        
        %>
                <tr>
        <%          for(String field : fields){ %>
                    <td><%= flight.get(field) %> </td>
        <%          }   %>
                    <td><%= total %> </td>
                </tr>
        <%
                }}
            }
        %>
            </table>
        </div>
            
        <% }  else if(selectingReturnFlight){      %>    
          
            <h2>Select Return Flight</h2>
        </div>
        
        <div class="employee-table">
            
            <table>
        
        <%  for(ArrayList<HashMap<String,String>> result : returnResults){   %>     
        
                <tr>

        <%      for(String field : columnHeaders){     %> 
                           
                    <th><%=field%></th>
        <%            
                }      
                    numOfFlights = result.size();

                    //create form that has hidden fields for each flight ID in current combo.  Form directs to confirmBooking.jsp
        %>
                    <th>Seats Left</th>
                    <th rowspan="<%=numOfFlights + 1%>"> 
                        <form action="searchResults.jsp">
        <%                    
                            int counter = 1;
                            for(HashMap<String,String> flight : result){ 
        %>                    
                            <input type="hidden" name="return_flight_id<%=counter%>" value="<%=flight.get("id") %>">
        <%                      counter++;
                            }
        %>                    
                            <input type="submit" value="Select" >
                        </form>
                    </th>
                </tr>
        <%      for(HashMap<String,String> flight : result){   

                    first_class_remaining = Integer.parseInt(flight.get("first_class_remaining"));
                    economy_remaining = Integer.parseInt(flight.get("economy_remaining"));
                    
                    total = first_class_remaining + economy_remaining;
        
        %>  
        
                <tr>
        <%          for(String field : fields){          %>
        
                    <td><%= flight.get(field) %> </td>
        <%          }   %>
                    <td><%= total %> </td>
                </tr>
        <%
                }
            }
        %>
            </table>
        </div>

        <% }    %>  
    </body>
</html>
