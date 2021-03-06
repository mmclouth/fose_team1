/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dbResources;

import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Properties;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author Kyle Anderson
 */
public class SendMail {
    private final String from = "fose.team1@gmail.com";
    private final String password = "foseteam1";
    private final String to;
    private final String host = "smtp.gmail.com";
    String result = "";
    boolean resultStatus = false;
    
    public SendMail(String to) {
        this.to = to;
    }
    
    public String send(boolean isCustomer) throws MessagingException {

        // Get system properties object
        Properties properties = System.getProperties();
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.user", from);
        properties.put("mail.smtp.password", password);
        properties.put("mail.smtp.port", 587);
        properties.put("mail.smtp.auth", "true");

        // Get the default Session object.
        Session mailSession = Session.getDefaultInstance(properties, null);
        String code;

        // Create a default MimeMessage object.
        MimeMessage message = new MimeMessage(mailSession);
        // Set From: header field of the header.
        message.setFrom(new InternetAddress(from));
        // Set To: header field of the header.
        message.addRecipient(MimeMessage.RecipientType.TO,
                                 new InternetAddress(to));
        // Set Subject: header field
        message.setSubject("Iowa Air Verification Code");
        
        if(isCustomer) {
            code = SendMail.generateVerificationCode();
            message.setText("Your verification code is: " + code);
        } else {
            code = SendMail.generateRandomPassword();
            message.setText("Your initial password is: " + code);
        }
        //placement = "after setText";
        // Send message
        Transport transport = mailSession.getTransport("smtp");
        transport.connect(host, from, password);
        transport.sendMessage(message, message.getAllRecipients());
        transport.close();
        return code;
    }
    
    public void send(boolean isCustomer, String code) throws MessagingException {

        // Get system properties object
        Properties properties = System.getProperties();
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.user", from);
        properties.put("mail.smtp.password", password);
        properties.put("mail.smtp.port", 587);
        properties.put("mail.smtp.auth", "true");

        // Get the default Session object.
        Session mailSession = Session.getDefaultInstance(properties, null);

        // Create a default MimeMessage object.
        MimeMessage message = new MimeMessage(mailSession);
        // Set From: header field of the header.
        message.setFrom(new InternetAddress(from));
        // Set To: header field of the header.
        message.addRecipient(MimeMessage.RecipientType.TO,
                                 new InternetAddress(to));
        // Set Subject: header field
        message.setSubject("Iowa Air Verification Code");
        
        if(isCustomer) {
            message.setText("Your verification code is: " + code);
        } else {
            message.setText("Your initial password is: " + code);
        }
        //placement = "after setText";
        // Send message
        Transport transport = mailSession.getTransport("smtp");
        transport.connect(host, from, password);
        transport.sendMessage(message, message.getAllRecipients());
        transport.close();
    }
    
    //random string generation found at 
    //http://stackoverflow.com/questions/41107/how-to-generate-a-random-alpha-numeric-string
    public static String generateVerificationCode() {
        String AB = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        final int LENGTH = 8;
        SecureRandom rnd = new SecureRandom();
        StringBuilder sb = new StringBuilder(LENGTH);
        for(int i = 0; i < LENGTH; i++) 
           sb.append( AB.charAt( rnd.nextInt(AB.length()) ) );
        return sb.toString();
    }
    
    public static String generateRandomPassword() {
        String num = "0123456789";
        String caps = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        String lower = "abcdefghijklmnopqrstuvwxyz";
        final int FIELDS = 3;
        final int LENGTH = 3;
        SecureRandom rnd = new SecureRandom();
        StringBuilder sb = new StringBuilder(LENGTH*FIELDS);
        for(int i = 0; i < LENGTH; i++) {
            sb.append( caps.charAt( rnd.nextInt(caps.length()) ) );
            sb.append( lower.charAt( rnd.nextInt(lower.length()) ) );
            sb.append( num.charAt( rnd.nextInt(num.length()) ) );
        }
        return sb.toString();
    }
    
    public String sendConfirmation(String price, ArrayList<String> flightNums) throws MessagingException {

        // Get system properties object
        Properties properties = System.getProperties();
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.user", from);
        properties.put("mail.smtp.password", password);
        properties.put("mail.smtp.port", 587);
        properties.put("mail.smtp.auth", "true");

        // Get the default Session object.
        Session mailSession = Session.getDefaultInstance(properties, null);
        String code;

        // Create a default MimeMessage object.
        MimeMessage message = new MimeMessage(mailSession);
        // Set From: header field of the header.
        message.setFrom(new InternetAddress(from));
        // Set To: header field of the header.
        message.addRecipient(MimeMessage.RecipientType.TO,
                                 new InternetAddress(to));
        // Set Subject: header field
        message.setSubject("Booking Confirmed!");
        
        StringBuilder sb = new StringBuilder();
        sb.append('\n');
        for(String s : flightNums) {
            sb.append(s);
            sb.append('\n');
        }
        
            code = SendMail.generateVerificationCode();
            message.setText("Congratulations! You have successfully booked "
                    + "the following flight(s):" + sb.toString() + "for a total "
                            + "price of $" + price + "0. Thank you for flying with "
                                    + "Iowa Air.");
        //placement = "after setText";
        // Send message
        Transport transport = mailSession.getTransport("smtp");
        transport.connect(host, from, password);
        transport.sendMessage(message, message.getAllRecipients());
        transport.close();
        return code;
    }
}
