package com.bookhub.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.bookhub.util.DBUtil;

/**
 * Servlet implementation class RecoveryServlet
 */
public class RecoveryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	RequestDispatcher dispatcher;
	private static final String EMAIL_SENDER = "help050bookhub@gmail.com"; // Replace with your email
	private static final String EMAIL_PASSWORD = "zmgvqibyeeywayas"; // Replace with your password
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RecoveryServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String email=(String) request.getParameter("email");
		
		try {
			String query = "SELECT fname,email FROM user WHERE email='"+email+"'";
			Connection con = DBUtil.getConnection();
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(query);
			rs.next();
			

			int index = email.indexOf('@');
			String pass = email.substring(0, index);
			//System.out.println("Password" + pass);

			if(rs.getString("email").equals(email))
			{
				
				String recipient = email;
		        
		      String sub ="BookHub Password Recovery Email";
		      String name = rs.getString("fname");
		      String msg ="<!DOCTYPE html>\r\n"
		      		+ "<html>\r\n"
		      		+ "<head>\r\n"
		      		+ "    <title>Password Recovery</title>\r\n"
		      		+ "</head>\r\n"
		      		+ "<body>\r\n"
		      		+ "    <h2>Password Recovery</h2>\r\n"
		      		+ "    <p>Hello "+name+",</p>\r\n"
		      		+ "    <p>We received a request to reset your password. If you didn't make the request, just ignore this email.</p>\r\n"
		      		+ "    <p>Otherwise, you can reset your password using this temporary password:</p>\r\n"
		      		+ "    <p><b>"+pass+"</b></p>\r\n"
		      		+ "    <p>Please make sure to change your password once you've logged in.</p>\r\n"
		      		+ "    <p>If you have any issues, please contact our support team.</p>\r\n"
		      		+ "    <p>Best,</p>\r\n"
		      		+ "    <p>BookHub Marketplace Team</p>\r\n"
		      		+ "</body>\r\n"
		      		+ "</html>\r\n"
		      		+ "";
		    		  
		    		  
		    		  
		      
		      String query2 = "UPDATE user SET password='"+pass+"' WHERE email ='"+email+"'";
		        int rows = st.executeUpdate(query2);
		       
		        
		        try {
		            send(recipient, sub, msg);
		            dispatcher = request.getRequestDispatcher("account-password-recovery.jsp?passEmail=success");
		        	dispatcher.forward(request, response);
		            //response.setContentType("text/html");
		            //PrintWriter out = response.getWriter();
		            //out.println("<h3>Email sent successfully!</h3>");
		            
		            
		        } catch (MessagingException e) {
		        	
		            //response.setContentType("text/html");
		            //PrintWriter out = response.getWriter();
		            //out.println("<h3>Error sending email: " + e.getMessage() + "</h3>");
		        	e.printStackTrace();
		            
		        }
		        
		        
		        
				
			}
		}catch(Exception e) {
			dispatcher = request.getRequestDispatcher("account-password-recovery.jsp?error=1");
        	dispatcher.forward(request, response);
			e.printStackTrace();
		}
		
	}
	private void send(String recipient, String subject, String message) throws MessagingException {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com"); // Replace with your SMTP server host
        props.put("mail.smtp.port", "587"); // Replace with your SMTP server port if different

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL_SENDER, EMAIL_PASSWORD);
            }
        });

        Message mail = new MimeMessage(session);
        mail.setFrom(new InternetAddress(EMAIL_SENDER));
        mail.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
        mail.setSubject(subject);
        mail.setContent(message, "text/html"); // Set content type as HTML if needed

        Transport.send(mail);
    }


}
