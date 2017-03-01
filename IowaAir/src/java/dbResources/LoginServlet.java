/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dbResources;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Nickolas
 */
@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet 
{
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        try 
        {
            LoginValidation login = new LoginValidation(username,password);
            
            int userId = login.findUserId();
            boolean correctPassword = login.isPasswordCorrect(userId);
            if(correctPassword)
            {
                if(!login.isValidated()){
                    login.setValidationStatus(true);
                }
                
                String userType = login.getUserType(userId);
                if (userType.equals("admin"))
                {
                    response.sendRedirect("/IowaAir/adminLanding.jsp");
                }
                else if(userType.equals("customer"))
                {
                    response.sendRedirect("/IowaAir/index.html");
                }
                else if(userType.equals("employee"))
                {
                    response.sendRedirect("/IowaAir/employeeLanding.jsp");
                }    
            }
            else
            {
                response.sendRedirect("/IowaAir/logIn.jsp");
            }
            
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }

    }
}
