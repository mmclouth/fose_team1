<%-- 
    Document   : confirmCancellation
    Created on : Apr 30, 2017, 9:22:34 PM
    Author     : Kyle Anderson
--%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.mail.MessagingException"%>
<%@page import="dbResources.Database.User_Types"%>
<%@page import="dbResources.SendMail"%>
<%@page import="dbResources.MD5Hashing"%>
<%@page import="dbResources.LoginValidation"%>
<%@page import="dbResources.Database"%>
<%
    Database db = new Database();
    boolean success = true;
    String flightID;
    String formattedDate = "";
    String firstDate = "";
    String firstTime = "";
    String current = "";
    String[] tmpCurrentArr = {""};
    String[] tmpCurrentArr2 = {""};
    String[] tmpFirstTimeArr = {""};
    String[] tmpFirstTimeArr2 = {""};
    String[] tmpFirstTimeArr3 = {""};
    String[] tmpCurrentArr3 = {""};
    String[] finalCurrArr = new String[6];
    String[] finalFirstTimeArr = new String[6];



    
    String bookingID = null, boardingPassID = null;
    ArrayList<String> boardingPassIDs = new ArrayList<String>();
    
    ArrayList<HashMap<String,String>> bookingInfo = new ArrayList<HashMap<String,String>>();
    ArrayList<HashMap<String,String>> boardingPassesInfo = new ArrayList<HashMap<String,String>>();
    HashMap<String,String> info;
    
    if(request.getParameter("boardingPassID") != null){
        boardingPassID = request.getParameter("boardingPassID");
    }
    
    if(request.getParameter("bookingID") != null){
        bookingID = request.getParameter("bookingID");
    }
    
    if(bookingID != null) {
        boardingPassIDs = db.selectArrayList("boarding_pass_id", "booking_has_boarding_pass", "booking_id", bookingID);
        String num = boardingPassIDs.get(0);
        flightID = db.selectString("flight_id", "boarding_pass", "id", num);
        firstDate = db.selectString("departure_date", "flight", "id", flightID);
        
        SimpleDateFormat formatter = new SimpleDateFormat("HH:mm:ss");
            Date dateOfFlight = formatter.parse(db.selectString("departure_time", "flight", "id", flightID));
            Calendar calend = Calendar.getInstance();
            // remove next line if you're always using the current time.
            calend.setTime(dateOfFlight);
            calend.add(Calendar.MINUTE, -45);
            dateOfFlight = calend.getTime();

            firstTime = dateOfFlight.toString().substring(0,dateOfFlight.toString().length()-10);
            firstTime = firstTime.substring(10);
        
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date currentDate = new Date();
            current = dateFormat.format(currentDate).toString();
        
            firstDate += " " + firstTime;
        
            tmpFirstTimeArr = firstDate.split("-");
            tmpCurrentArr = current.split("-");
            
            tmpFirstTimeArr2 = tmpFirstTimeArr[2].split(" ");
            tmpCurrentArr2 = tmpCurrentArr[2].split(" ");
            
            tmpFirstTimeArr3 = tmpFirstTimeArr2[2].split(":");
            tmpCurrentArr3 = tmpCurrentArr2[1].split(":");
            
            for(int i = 0; i < tmpCurrentArr.length; i++) {
                finalCurrArr[i] = tmpCurrentArr[i];
                finalFirstTimeArr[i] = tmpFirstTimeArr[i];
            }
            finalCurrArr[2] = tmpCurrentArr2[0];
            finalFirstTimeArr[2] = tmpFirstTimeArr2[0];
            
            for(int i = 0; i < tmpFirstTimeArr.length; i++) {
                finalCurrArr[i + 3] = tmpCurrentArr3[i];
                finalFirstTimeArr[i + 3] = tmpFirstTimeArr3[i];
            }
            
            if(Integer.parseInt(finalCurrArr[0]) > Integer.parseInt(finalFirstTimeArr[0])) {
                success = false;
            } else if((Integer.parseInt(finalCurrArr[0]) == Integer.parseInt(finalFirstTimeArr[0]) //same year
                        && (Integer.parseInt(finalCurrArr[1]) > Integer.parseInt(finalFirstTimeArr[1])))) { //later month
                success = false;
            } else if((Integer.parseInt(finalCurrArr[0]) == Integer.parseInt(finalFirstTimeArr[0]) //same year
                        && (Integer.parseInt(finalCurrArr[1]) == Integer.parseInt(finalFirstTimeArr[1])) //same month
                        && (Integer.parseInt(finalCurrArr[2]) > Integer.parseInt(finalFirstTimeArr[2])))) { //later day
                success = false;
            } else if((Integer.parseInt(finalCurrArr[0]) == Integer.parseInt(finalFirstTimeArr[0]) //same year
                        && (Integer.parseInt(finalCurrArr[1]) == Integer.parseInt(finalFirstTimeArr[1])) //same month
                        && (Integer.parseInt(finalCurrArr[2]) == Integer.parseInt(finalFirstTimeArr[2])) //same day
                        && (Integer.parseInt(finalCurrArr[3]) > Integer.parseInt(finalFirstTimeArr[3])))) { //later hour
                success = false;
            } else if((Integer.parseInt(finalCurrArr[0]) == Integer.parseInt(finalFirstTimeArr[0]) //same year
                        && (Integer.parseInt(finalCurrArr[1]) == Integer.parseInt(finalFirstTimeArr[1])) //same month
                        && (Integer.parseInt(finalCurrArr[2]) == Integer.parseInt(finalFirstTimeArr[2])) //same day
                        && (Integer.parseInt(finalCurrArr[3]) == Integer.parseInt(finalFirstTimeArr[3])) //same hour
                        && (Integer.parseInt(finalCurrArr[4]) > Integer.parseInt(finalFirstTimeArr[4])))) { //later minute
                success = false;
            } else if((Integer.parseInt(finalCurrArr[0]) == Integer.parseInt(finalFirstTimeArr[0]) //same year
                        && (Integer.parseInt(finalCurrArr[1]) == Integer.parseInt(finalFirstTimeArr[1])) //same month
                        && (Integer.parseInt(finalCurrArr[2]) == Integer.parseInt(finalFirstTimeArr[2])) //same day
                        && (Integer.parseInt(finalCurrArr[3]) == Integer.parseInt(finalFirstTimeArr[3])) //same hour
                        && (Integer.parseInt(finalCurrArr[4]) == Integer.parseInt(finalFirstTimeArr[4])) //same minute
                        && (Integer.parseInt(finalCurrArr[5]) > Integer.parseInt(finalFirstTimeArr[5])))) { //later second
                success = false;
            }
        
        if(success) {    
            for(String id : boardingPassIDs) {
                info = new HashMap<String,String>();

                info.put("id", id);

                flightID = db.selectString("flight_id", "boarding_pass", "id", id);
                info.put("flight_num", db.selectString("num", "flight", "id", flightID));
                info.put("flight_date", db.selectString("departure_date", "flight", "id", flightID));
                info.put("origin", db.selectString("origin_code", "flight", "id", flightID));
                info.put("destination", db.selectString("destination_code", "flight", "id", flightID));
                info.put("departure_time", db.selectString("departure_time", "flight", "id", flightID));

                SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
                Date date = sdf.parse(info.get("departure_time"));
                Calendar cal = Calendar.getInstance();
                // remove next line if you're always using the current time.
                cal.setTime(date);
                cal.add(Calendar.MINUTE, -45);
                date = cal.getTime();

                formattedDate = date.toString().substring(0,date.toString().length()-10);
                formattedDate = formattedDate.substring(10);

                info.put("boarding_time", formattedDate);


                info.put("arrival_time", db.selectString("arrival_time", "flight", "id", flightID));     

                info.put("passenger_name", db.selectString("passenger_name", "boarding_pass", "id", id));
                info.put("clas", db.selectString("clas", "boarding_pass", "id", id));
                info.put("seat_num", db.selectString("seat_num", "boarding_pass", "id", id));

                boardingPassesInfo.add(info);
                db.deleteBoardingPass(id);
            }
        }
    }
    
    db.closeConnection();
    
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Iowa Air: Flight Cancellation</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/css?family=Catamaran" rel="stylesheet">
        <link rel="stylesheet" href="style.css">
    </head>
    <body>

        <% if (session.getAttribute("userID") == null) { %>

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
            <% }%>

            <a class="title" href="<%= session.getAttribute("homePage")%>"><h1>Iowa Air</h1></a>
            <a class="links" href="<%=request.getContextPath()%>/LogoutServlet"><h2>Log Out</h2></a>
            <h3>|</h3>
            <a class="links" href="userProfile.jsp" ><h4><%= session.getAttribute("userFirstName")%>'s Profile</h4></a>
        </div>

        <% }%>

        <div class="user-toolbar">
            <ul>
                <li><a href="userFlightHistory.jsp">My Flight History</a></li>
                <li><a class="active" href="userBookingHistory.jsp">My Booking History</a></li>
                <li><a href="changePassword.jsp">Change My Password</a></li>
            </ul>  
        </div>

        <div class="middle">
            <h1>Flight Cancellation</h1>
            <% if(success) { %>
            <h4>Your flight booking has been canceled.</h4>
            <% } else { %>
            <h4>Unfortunately, it is too late to cancel your booking.</h4>
            <% } %>
            
        </div>
        <div class="clear"></div> 
    </body>
</html>


