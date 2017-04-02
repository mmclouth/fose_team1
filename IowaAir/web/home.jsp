<%-- 
    Document   : home
    Created on : Mar 4, 2017, 2:26:24 PM
    Author     : kenziemclouth
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="dbResources.Database"%>
<%
    
    Database db = new Database();
    ArrayList<String> airports = db.getAllAirportCodes();
    
    db.closeConnection();
    
%>    


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    
    <head>
        
        <script language="Javascript">
            function rTrip(){
                
                document.getElementById("form1").style.visibility="visible"; 
                
                document.getElementById("returnDate").style.visibility="visible"; 
                document.getElementById("returnDateLabel").style.visibility="visible"; 
                document.getElementById("multiAddFlight").style.visibility="hidden";
                
                document.getElementById("flight4div").style.visibility="hidden";
                document.getElementById("flight3div").style.visibility="hidden";
                
                hideFlight3();
               
                hideFlight4();
                
                document.getElementById("form2").style.visibility="hidden"; 
            }

            function oneWay(){
                document.getElementById("form2").style.visibility="hidden"; 
                document.getElementById("form1").style.visibility="visible"; 
                
                document.getElementById("returnDate").style.visibility="hidden"; 
                document.getElementById("returnDateLabel").style.visibility="hidden";   
                
                document.getElementById("multiAddFlight").style.visibility="hidden";
                
                hideFlight3();
                hideFlight4();
            }
            
            function multi(){
                document.getElementById("form2").style.visibility="visible"; 
                document.getElementById("form1").style.visibility="hidden"; 
                
                document.getElementById("returnDate").style.visibility="hidden"; 
                document.getElementById("returnDateLabel").style.visibility="hidden";
                
                document.getElementById("multiAddFlight").style.visibility="visible";
                document.getElementById("multiAddFlight").setAttribute( "onClick", "javascript: addFlight3();" );
                hideFlight3();
               
                hideFlight4();

            }      
    
            function addFlight3(){
                if(isHidden(document.getElementById("multiFlightOriginLabel3")))
                {
                    
                    document.getElementById("flight3div").style.visibility="visible";
                    document.getElementById("multiFlightOriginLabel3").style.visibility="visible"; 
                    document.getElementById("multiFlightDestinationLabel3").style.visibility="visible"; 
                    document.getElementById("multiFlightDepartLabel3").style.visibility="visible"; 
                
                    document.getElementById("multiFlightOrigin3").style.visibility="visible"; 
                    document.getElementById("multiFlightDestination3").style.visibility="visible"; 
                    document.getElementById("multiFlightDepart3").style.visibility="visible";
                    
                    document.getElementById("flight3").style.visibility="visible"; 
                    

                }
                
                document.getElementById("multiAddFlight").setAttribute( "onClick", "javascript: addFlight4();" );
            }
            
            function addFlight4(){
                if(isHidden(document.getElementById("multiFlightOriginLabel4")))
                {
                        
                    document.getElementById("flight4div").style.visibility="visible";
                    document.getElementById("multiFlightOriginLabel4").style.visibility="visible"; 
                    document.getElementById("multiFlightDestinationLabel4").style.visibility="visible"; 
                    document.getElementById("multiFlightDepartLabel4").style.visibility="visible"; 
                
                    document.getElementById("multiFlightOrigin4").style.visibility="visible"; 
                    document.getElementById("multiFlightDestination4").style.visibility="visible"; 
                    document.getElementById("multiFlightDepart4").style.visibility="visible";
                    
                    document.getElementById("flight4").style.visibility="visible";
                   

                }
            }
            
            function hideFlight3(){
                document.getElementById("flight3div").style.visibility="hidden";
                
                document.getElementById("flight3").style.visibility="hidden"; 
                
                document.getElementById("multiFlightOriginLabel3").style.visibility="hidden"; 
                document.getElementById("multiFlightDestinationLabel3").style.visibility="hidden"; 
                document.getElementById("multiFlightDepartLabel3").style.visibility="hidden"; 
                
                document.getElementById("multiFlightOrigin3").style.visibility="hidden"; 
                document.getElementById("multiFlightDestination3").style.visibility="hidden"; 
                document.getElementById("multiFlightDepart3").style.visibility="hidden";
            }
            
            function hideFlight4(){
                document.getElementById("flight4div").style.visibility="hidden";
                
                document.getElementById("flight4").style.visibility="hidden"; 
                
                document.getElementById("multiFlightOriginLabel4").style.visibility="hidden"; 
                document.getElementById("multiFlightDestinationLabel4").style.visibility="hidden"; 
                document.getElementById("multiFlightDepartLabel4").style.visibility="hidden"; 
                
                document.getElementById("multiFlightOrigin4").style.visibility="hidden"; 
                document.getElementById("multiFlightDestination4").style.visibility="hidden"; 
                document.getElementById("multiFlightDepart4").style.visibility="hidden";
            }
            

                
            function isHidden(element){
                return element.offsetWidth > 0 && element.offsetHeight > 0;
            }
                    
    </script>
        
    
    <title>Iowa Air</title>
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
        
        <div class="title-top">
            <% if (session.getAttribute("validation_status") != null && session.getAttribute("validation_status").equals("0")) { %>
            <div class="validate_account_bar">
                <h10>  You have not validated your account yet.  <a href="signUpConfirmation.jsp">Click here</a> to enter your confirmation code.</h10>
            </div>
            <% } %>
            
            <a class="title" href="<%= session.getAttribute("homePage")%>"><h1>Iowa Air</h1></a>
            <a class="links" href="<%=request.getContextPath()%>/LogoutServlet"><h2>Log Out</h2></a>
            <h3>|</h3>
            <a class="links" href="userProfile.jsp" ><h4><%= session.getAttribute("userFirstName")%>'s Profile</h4></a>

        </div>
        
        <% } %>
        
        

        <div class="middle">
            <h1>Home Page</h1>

            <form id="radioButtons" >
                <input type="radio" name="search_type" value="round_trip" checked onClick="rTrip()"> Round Trip<br>
                <input type="radio" name="search_type" value="one_way" onClick="oneWay()"> One Way<br>
                <input type="radio" name="search_type" value="multi" onClick="multi()"> Multi-City <br>
            </form>
            
            <form id="form1" action="searchResults.jsp">
                <label for="origin">Origin:</label>
                <select name="origin">
                    <option value="null">------</option>
    <%
                     for(String airport : airports){      
    %>
                    <option value="<%=airport%>"><%=airport%></option>     
                    
                    <% } %>                  
                </select>    
                <br> 
                <label for="destination">Destination:</label>
                <select name="destination">
                    <option value="null">------</option>
    <%
                     for(String airport : airports){      
    %>
                    <option value="<%=airport%>"><%=airport%></option>     
                    
                    <% } %>                  
                </select>  
                <br>
                <label for="d_date">Departure Date:</label>
                <input type="date" name ="d_date">
                <label id = "returnDateLabel" for="r_date">Return Date:</label>
                <input id="returnDate" type="date" name ="r_date"> <br>
                <label for="num_of_passengers">Number of Passengers:</label>
                <input type="number" name ="num_of_passengers"> <br>
                
                <div class="search-button">
                    <button type="submit" value="Submit">Search</button>
                </div>
            </form>
            
            <div class="multiflight">
            <form id="form2" action="searchResults.jsp">
                
                <div class="numOfPassBox">
                <label for="num_of_passengers">No. of Passengers:</label>
                <input type="number" name ="num_of_passengers">
                </div>
                
                <div class="flightBox">
                <p id="flight1">Flight 1</p>
                <label id = "multiFlightOriginLabel1" for="multiFlightOrigin1">Flight Origin:</label>
            
                <select name="multiFlightOrigin1">
                    <option value="null">------</option>
    <%
                     for(String airport : airports){      
    %>
                    <option value="<%=airport%>"><%=airport%></option>     
                    
                    <% } %>                  
                </select>  
                <br>
                
                <label id = "multiFlightDestinationLabel1" for="multiFlightDestination1">Flight Destination:</label>
               
                <select name="multiFlightDestination1">
                    <option value="null">------</option>
    <%
                     for(String airport : airports){      
    %>
                    <option value="<%=airport%>"><%=airport%></option>     
                    
                    <% } %>                  
                </select>  
                <br>
                
                <label id = "multiFlightDepartLabel1" for="multiFlightDepart1">Flight Depart Date:</label>
                <input id="multiFlightDepart1" type="date" name ="multiFlightDepart1"><br>
                </div>
                
                
                <div class="flightBox">
                <p id='flight2'>Flight 2</p>
                <label id = "multiFlightOriginLabel2" for="multiFlightOrigin2">Flight Origin:</label>
                <select name="multiFlightOrigin2">
                    <option value="null">------</option>
    <%
                     for(String airport : airports){      
    %>
                    <option value="<%=airport%>"><%=airport%></option>     
                    
                    <% } %>                  
                </select>  
                <br>
                
                <label id = "multiFlightDestinationLabel2" for="multiFlightDestination2">Flight Destination:</label>
                <select name="multiFlightDestination2">
                    <option value="null">------</option>
    <%
                     for(String airport : airports){      
    %>
                    <option value="<%=airport%>"><%=airport%></option>     
                    
                    <% } %>                  
                </select>  
                <br>
                
                <label id = "multiFlightDepartLabel2" for="multiFlightDepart2">Flight Depart Date:</label>
                <input id="multiFlightDepart2" type="date" name ="multiFlightDepart2"><br>
                
                </div>
                
                
                
                <div class="flightBox" id="flight3div">
                    <p id="flight3">Flight 3</p>
                    <label id = "multiFlightOriginLabel3" for="multiFlightOrigin3">Flight Origin:</label>
                    <select name="multiFlightOrigin3">
                        <option value="null">------</option>
    <%
                     for(String airport : airports){      
    %>
                    <option value="<%=airport%>"><%=airport%></option>     
                    
                    <% } %>                  
                </select>  
                <br>
                
                    <label id = "multiFlightDestinationLabel3" for="multiFlightDestination3">Flight Destination:</label>
                    <select name="multiFlightDestination3">
                        <option value="null">------</option>
    <%
                     for(String airport : airports){      
    %>
                        <option value="<%=airport%>"><%=airport%></option>     
                    
                    <% } %>                  
                    </select>  
                <br>
                
                    <label id = "multiFlightDepartLabel3" for="multiFlightDepart3">Flight Depart Date:</label>
                    <input id="multiFlightDepart3" type="date" name ="multiFlightDepart3"><br>
                
                </div>
                
                <div class="flightBox" id="flight4div">
                    <p id="flight4">Flight 4</p>
                    <label id = "multiFlightOriginLabel4" for="multiFlightOrigin4">Flight Origin:</label>
                    <select name="multiFlightOrigin4">
                        <option value="null">------</option>
    <%
                     for(String airport : airports){      
    %>
                        <option value="<%=airport%>"><%=airport%></option>     
                    
                    <% } %>                  
                    </select>  
                <br>
                
                    <label id = "multiFlightDestinationLabel4" for="multiFlightDestination4">Flight Destination:</label>
                    <select name="multiFlightDestination4">
                        <option value="null">------</option>
    <%
                     for(String airport : airports){      
    %>
                    <option value="<%=airport%>"><%=airport%></option>     
                    
                    <% } %>                  
                </select>  
                <br>
                
                    <label id = "multiFlightDepartLabel4" for="multiFlightDepart4">Flight Depart Date:</label>
                    <input id="multiFlightDepart4" type="date" name ="multiFlightDepart4"><br>
                </div>
                
                <div class="search-button">
                    <button  id="multiAddFlight" type="button" onClick="addFlight3()">Add Flight </button>
                </div>
                
                <div class="search-button">
                    <button type="submit" value="Submit">Search</button>
                </div>
                
            </form>
            </div>

        </div>
        
        <script language="Javascript">
            
            
            document.getElementById("form2").style.visibility="hidden";
            document.getElementById("flight4div").style.visibility="hidden";
            document.getElementById("flight3div").style.visibility="hidden";

        </script>    

    </body>
    
        
</html>

