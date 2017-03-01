<%-- 
    Document   : signUpConfirmation
    Created on : Feb 20, 2017, 7:56:18 PM
    Author     : Kyle Anderson
--%>

<%@ page import="java.io.*,java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
   String result = "";
   boolean resultStatus = false;
   // Recipient's email ID needs to be mentioned.
   String to = request.getParameter("username");

   // Sender's email ID needs to be mentioned
   String from = "fose.team1@gmail.com";
   String password = "foseteam1";

   // Assuming you are sending email from localhost
   String host = "smtp.gmail.com";

   // Get system properties object
   Properties properties = System.getProperties();
   properties.put("mail.smtp.starttls.enable", "true");
   properties.put("mail.smtp.host", host);
   properties.put("mail.smtp.user", from);
   properties.put("mail.smtp.password", password);
   properties.put("mail.smtp.port", 587);
   properties.put("mail.smtp.auth", "true");
   

   // Setup mail server
   //properties.setProperty("mail.smtp.host", host);

   // Get the default Session object.
   Session mailSession = Session.getDefaultInstance(properties, null);
   

   try{
      // Create a default MimeMessage object.
      MimeMessage message = new MimeMessage(mailSession);
      // Set From: header field of the header.
      message.setFrom(new InternetAddress(from));
      // Set To: header field of the header.
      message.addRecipient(MimeMessage.RecipientType.TO,
                               new InternetAddress(to));
      // Set Subject: header field
      message.setSubject("This is the Subject Line!");
      // Now set the actual message
      message.setText("This is actual message");
      //placement = "after setText";
      // Send message
      //Transport.send(message);
      Transport transport = mailSession.getTransport("smtp");
      transport.connect(host, from, password);
      transport.sendMessage(message, message.getAllRecipients());
      transport.close();
      result = "Sent message successfully....";
      resultStatus = true;
   }catch (MessagingException mex) {
       result = "Error thrown here";
      mex.printStackTrace();
   }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Iowa Air: Confirmation</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/css?family=Catamaran" rel="stylesheet">
        <link rel="stylesheet" href="style.css">
    </head>
    <body>
        
        <div class="title-top">
            <a class="title" href="index.html"><h1>Iowa Air</h1></a>
            <a class="links" href="logIn.jsp" ><h2>Log In</h2></a>
            <h3>|</h3>
            <a class="links" href="signUp.jsp" ><h2>Sign Up</h2></a>
        </div>

        <div class="middle">
            <h1>Confirmation</h1>
            
            <% if(resultStatus)
            {
            %>
            <form action="signUpConfirmation.jsp"> 
                A confirmation link has been sent to your e-mail. Please enter
                the confirmation code provided in the e-mail into the field 
                below.
                Confirmation code:
                <input type="text" value="confirm"><br>
            <% } else { %>
                ERROR! There was a problem with the e-mail address you provided.
                Please click the link below to return to the sign up page and 
                enter a valid e-mail.
                <a href="signUp.jsp">Return to Sign Up Page</a><br>
            <% } %>
        </div>

    </body>
</html>
