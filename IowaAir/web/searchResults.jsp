<%-- 
    Document   : searchResults
    Created on : Feb 14, 2017, 2:06:46 PM
    Author     : kenziemclouth
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="dbResources.Search"%>
<%
    String origin_code, destination_code, departure_date, return_date;
    boolean return_flight = false;
    ArrayList<ArrayList<HashMap<String,String>>> returnResults = new ArrayList<ArrayList<HashMap<String,String>>>();
    int num_of_passengers;
    
    int numOfFlights;
    
    //retrieve request parameters from search
    if (request.getParameter("origin") != null) 
    {
        origin_code = request.getParameter("origin");
    } else {
        origin_code = "n/a";
    }
    
    if (request.getParameter("destination") != null) 
    {
        destination_code = request.getParameter("destination");
    } else {
        destination_code = "n/a";
    }
    
    if (request.getParameter("d_date") != null) 
    {
        departure_date = request.getParameter("d_date");
    } else {
        departure_date = "n/a";
    }
    if (request.getParameter("r_date") != null && !request.getParameter("r_date").equals("")) 
    {
        return_date = request.getParameter("r_date");
        return_flight = true;
    } else {
        return_date = "n/a";
    }
    if (request.getParameter("num_of_passengers") != null && !request.getParameter("num_of_passengers").equals("")) 
    {
        num_of_passengers = Integer.parseInt(request.getParameter("num_of_passengers"));
    } else {
        num_of_passengers = 1;
    }

    //Parse date from date string
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    Date d_date = formatter.parse(departure_date);
    
    //Create Search object and then retrieve search results
    Search search = new Search(origin_code, destination_code, d_date);
    ArrayList<ArrayList<HashMap<String,String>>> searchResults = search.getSearchResults2();
    
    //if return flight was specified, parse date, create Search object, retrieve search results
    if(return_flight){
        Date r_date = formatter.parse(return_date);
        search = new Search(destination_code, origin_code, r_date);
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

            <h2>Departing Flight</h2>
        </div>
        
        <div class="employee-table">
            
            <table>
        
        <%
            String[] fields = {"id","num","origin_code","destination_code","departure_date","arrival_date","departure_time","arrival_time"};
            
            //iterate through each flight combo
            for(ArrayList<HashMap<String,String>> result : searchResults){
                
        %>
                <tr>

        <%      for(String field : fields){                     //print out table headers for each combo to separate options%>            
                    
                    <th><%=field%></th>
        
        <%            
                }
                numOfFlights = result.size();

                //create form that has hidden fields for each flight ID in current combo.  Form directs to confirmBooking.jsp
        %>
                    <th rowspan="<%=numOfFlights + 1%>"> 
                        <form action="confirmBooking.jsp">
        <%                    
                            int counter = 1;
                            for(HashMap<String,String> flight : result){ 
        %>                    
                            <input type="hidden" name="flight_id<%=counter%>" value="<%=flight.get("id") %>">
        <%                      counter++;
                            }
        %>                    
                            <input type="submit" value="Book" >
                        </form>
                    </th>
                </tr>
        <%      for(HashMap<String,String> flight : result){      %>
                <tr>
        <%          for(String field : fields){ %>
                    <td><%= flight.get(field) %> </td>
        <%          }   %>
                </tr>
        <%
                }
            }
        %>
            </table>
        </div>
            
        <%  if(return_flight){      %>    
          
        <div class="middle">
            <h2>Return Flight</h2>
        </div>
        
        <div class="employee-table">
            
            <table>
        
        <%  for(ArrayList<HashMap<String,String>> result : returnResults){   %>     
        
                <tr>

        <%      for(String field : fields){     %> 
                           
                    <th><%=field%></th>
        <%            
                }      
                    numOfFlights = result.size();

                    //create form that has hidden fields for each flight ID in current combo.  Form directs to confirmBooking.jsp
        %>
                    <th rowspan="<%=numOfFlights + 1%>"> 
                        <form action="confirmBooking.jsp">
        <%                    
                            int counter = 1;
                            for(HashMap<String,String> flight : result){ 
        %>                    
                            <input type="hidden" name="flight_id<%=counter%>" value="<%=flight.get("id") %>">
        <%                      counter++;
                            }
        %>                    
                            <input type="submit" value="Book" >
                        </form>
                    </th>
                </tr>
        <%      for(HashMap<String,String> flight : result){    %>  
        
                <tr>
        <%          for(String field : fields){          %>
        
                    <td><%= flight.get(field) %> </td>
        <%          }   %>
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
