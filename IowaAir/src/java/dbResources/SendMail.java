/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dbResources;

import java.security.SecureRandom;
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
    
    public void send() throws MessagingException {

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

        String code = SendMail.generateVerificationCode();

        // Create a default MimeMessage object.
        MimeMessage message = new MimeMessage(mailSession);
        // Set From: header field of the header.
        message.setFrom(new InternetAddress(from));
        // Set To: header field of the header.
        message.addRecipient(MimeMessage.RecipientType.TO,
                                 new InternetAddress(to));
        // Set Subject: header field
        message.setSubject("Iowa Air Verification Code");
        // Send the verification code
        message.setText("Your verification code is: " + code);
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
}
