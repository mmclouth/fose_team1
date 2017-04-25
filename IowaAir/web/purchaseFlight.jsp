<%-- 
    Document   : purchaseFlight
    Created on : Apr 2, 2017, 5:54:46 PM
    Author     : Kyle Anderson
--%>
<%@page import="javax.mail.MessagingException"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Enumeration"%>
<%@page import="dbResources.SendMail"%>
<%@page import="dbResources.Payment"%>
<%@page import="dbResources.Database"%>
<%@page import="java.util.Map"%>
<%  Map<String,String[]> parameters = request.getParameterMap();
    
    Enumeration<String> attributes = session.getAttributeNames();
    String errorMessage = null;
    
    String cardNum = null, cvv = null, price = null, ticketType = null;
    Integer userID = null;
    
    Integer passenger_user_id = null;
    
    String[] flightIDs = null, seatsAvailable = null;
    
    String userType = "customer";
    
    if(session.getAttribute("user_type") != null) {
        userType = (String) session.getAttribute("user_type");
    }
    
    if(session.getAttribute("numSeats") != null) {
        seatsAvailable = (String[]) session.getAttribute("numSeats");
    }
    
    if(session.getAttribute("userID") != null) {
        userID = (Integer)session.getAttribute("userID");
    }
    
    if(session.getAttribute("passenger_user_id") != null) {
        userID = Integer.parseInt((String)session.getAttribute("passenger_user_id"));
    }
    
    if(session.getAttribute("type_of_tickets") != null) {
        String[] types = (String[]) session.getAttribute("type_of_tickets");
        ticketType = types[0];
    }
    
    if(session.getAttribute("flight_ids") != null) {
        flightIDs = (String[]) session.getAttribute("flight_ids");
    }
    //Retrieve parameters from request if they have been sent from previous page
    if (session.getAttribute("price") != null) {
        String[] prices = (String[]) session.getAttribute("price");
        price = prices[0];
        //errorMessage = "Price is" + price + " <br>";
    }
    if (request.getParameter("cardNumber") != null) {
        cardNum = request.getParameter("cardNumber");
        //errorMessage += "Card number is " + cardNum + " <br>";
    }
    if (request.getParameter("cvv") != null) {
        cvv = request.getParameter("cvv");
        //errorMessage += "CVV number is " + cvv + " <br>";
    }
    
    Database db = new Database();
    String email = null;
    if (price != null && cardNum != null && cvv != null && userID != null) {
        email = db.getUserEMail(Integer.toString(userID));

        boolean allFieldsValid = true;
        errorMessage = "";
        
        if(!Payment.cardNumberIsValid(cardNum)) {
            errorMessage = "Card number must be 10 digits. ";
            allFieldsValid = false;
        }
        if(!Payment.cvvIsValid(cvv)) {
            errorMessage += "CVV must be 3 digits. <br>";
            allFieldsValid = false;
        }
        
        if(allFieldsValid) {
            errorMessage = null;
            for(int i = 0; i < flightIDs.length; ++i ) {
                
                //update economy flight seats
                if(ticketType.equals("economy")) {
                    int seats = Integer.parseInt(seatsAvailable[i]);
                    int flight = Integer.parseInt(flightIDs[i]);
                    db.updateFlightFirstClassSeatsRemaining(seats, flight);
                }
                
                //update first class flight seats
                if(ticketType.equals("first_class")) {
                    int seats = Integer.parseInt(seatsAvailable[i]);
                    int flight = Integer.parseInt(flightIDs[i]);
                    db.updateFlightEconomySeatsRemaining(seats, flight);
                }
            }
            ArrayList<String> flightNums = new ArrayList<String>();
            ArrayList<String> boardingPassIDs = new ArrayList<String>();
            
            ArrayList<String> firstNames = (ArrayList)session.getAttribute("firstNames");
            ArrayList<String> lastNames = (ArrayList)session.getAttribute("lastNames");
            ArrayList<String> seatNums = (ArrayList)session.getAttribute("seatNums");
            ArrayList<String> luggageCounts = (ArrayList)session.getAttribute("luggageCounts");
            
            
            for(int i = 0; i < flightIDs.length; ++i) {
                HashMap<String, String> mapToAdd = db.getHashMapForFLight(flightIDs[i]);
                String flightNumber = mapToAdd.get("num");
                flightNums.add(flightNumber);
            }
            
            for(int i = 0; i < flightIDs.length; ++i){
                
                for(int j=0 ; j<firstNames.size() ; j++){
                    String passengerName = firstNames.get(j) + " " + lastNames.get(j);
                
                    db.addBoardingPass(Integer.parseInt(flightIDs[i]), userID, ticketType, passengerName, seatNums.get(j), Integer.parseInt(luggageCounts.get(j)));     //db.addBoardingPass(Integer.parseInt(flightIDs[i]), userID, ticketType);
                }        
            }
            
            
            
            for(int i = 0; i < flightIDs.length; ++i)
                boardingPassIDs.addAll(db.selectArrayList("id", "boarding_pass", "flight_id", flightIDs[i], "userr_id", Integer.toString(userID), "clas", ticketType));
                
            db.createBooking(boardingPassIDs, (Integer) session.getAttribute("num_of_passengers"));
            try { 
            SendMail mailer = new SendMail(email);
            if(mailer == null) response.sendRedirect("/IowaAir/home.jsp");
            mailer.sendConfirmation(price, flightNums);
            
            session.setAttribute("booked", true);
            if(userType.equals("employee")){
                response.sendRedirect("/IowaAir/employeeLanding.jsp");
            } else {
            
                response.sendRedirect("/IowaAir/userFlightHistory.jsp");
            }
            } catch (MessagingException me) {
                me.printStackTrace();
                response.sendRedirect("/IowaAir/home.jsp");
            }
            
                
            
        }
        
    }
%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Purchase Flight</title>
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
        
        <div class="middle">
            In order to purchase your flight, you must be signed into your account.
            Please click here to
            <a class="links" href="signUp.jsp" >sign up</a> or 
            <a class="links" href="logIn.jsp" >log in.</a> 
        </div>
        
        <% } else { %>
        
        <div class="title-top">

            <% if (session.getAttribute("validation_status") != null && session.getAttribute("validation_status").equals("0")) { %>
            <div class="validate_account_bar">
                <h10>  You have not validated your account yet.  <a href="signUpConfirmation.jsp">Click here</a> to enter your confirmation code.</h10>
            </div>
            <% }%>

            <a class="title" href="<%= session.getAttribute("homePage")%>"><h1>Iowa Air</h1></a>
            <a class="links" href="<%=request.getContextPath()%>/LogoutServlet"><h2>Log Out</h2></a>
            <h3>|</h3>
            <a class="links" href="userProfile.jsp" ><h4><%= session.getAttribute("userFirstName")%>'s Profile</h4></a>
        </div>
        
        <% if (errorMessage != null) {%>

            <h2 class="failure"><%= errorMessage%></h2> <br>

        <% }%>
        
        <div class="middle">
            <form action="purchaseFlight.jsp" method="post">
                <h1>Purchase Flight</h1>
                <h3> Total Price $<%=price%>0 </h3>
                <input type="hidden" name="price" value="<%=price%>">
                <% for(String s : flightIDs) { %>
                <input type="hidden" name="flight_ids" value="<%= s %>">
                <% } %>
                <% for(String s : seatsAvailable) { %>
                <input type="hidden" name="numSeats" value="<%= s %>">
                <% } %>
                <input type="hidden" name="type_of_tickets" value="<%= ticketType %>">
                Credit card number: 
                <input type="text" name="cardNumber" required><br>
                Expiration date: <br>
                Month: 
                <select>
                    <option value="january">01</option>
                    <option value="february">02</option>
                    <option value="march">03</option>
                    <option value="april">04</option>
                    <option value="may">05</option>
                    <option value="june">06</option>
                    <option value="july">07</option>
                    <option value="august">08</option>
                    <option value="september">09</option>
                    <option value="october">10</option>
                    <option value="november">11</option>
                    <option value="december">12</option>
                </select>
                Year: 
                <select>
                    <option value="2017">17</option>
                    <option value="2018">18</option>
                    <option value="2019">19</option>
                    <option value="2020">20</option>
                    <option value="2021">21</option>
                    <option value="2022">22</option>
                    <option value="2023">23</option>
                    <option value="2024">24</option>
                    <option value="2025">25</option>
                    <option value="2026">26</option>
                    <option value="2027">27</option>
                    <option value="2028">28</option>
                    <option value="2029">29</option>
                    <option value="2030">30</option>
                    <option value="2031">31</option>
                    <option value="2032">32</option>
                    <option value="2033">33</option>
                    <option value="2034">34</option>
                    <option value="2035">35</option>
                </select><br>
                CVV:
                <input type="text" name="cvv" required><br>
                <input type="submit" value="Finalize purchase"><br>
            </form>
                
        </div>
        <% } %>
    </body>
</html>
