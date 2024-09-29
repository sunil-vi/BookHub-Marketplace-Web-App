package com.bookhub.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.util.Properties;
import java.io.IOException;
import java.io.PrintWriter;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;



/**
 * Servlet implementation class SendMailServlet
 */
public class SendMailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String EMAIL_SENDER = "help050bookhub@gmail.com"; // Replace with your email
	private static final String EMAIL_PASSWORD = "zmgvqibyeeywayas"; // Replace with your password
	RequestDispatcher dispatcher;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SendMailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	    
	    

	        String recipient = request.getParameter("recipient");
	        String subject = request.getParameter("subject");
	        String message = request.getParameter("message");
	        String name = request.getParameter("name");
	        
	      String sub ="BookHub"; 
	      String msg ="<!DOCTYPE html>\r\n"
	      		+ "<html lang=\"en\">\r\n"
	      		+ "<head>\r\n"
	      		+ "  <meta charset=\"UTF-8\">\r\n"
	      		+ "  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n"
	      		+ "  <title>BookHub Marketplace - Contact Us Reply</title>\r\n"
	      		+ "</head>\r\n"
	      		+ "<body><h2>Subject: Re: Your Contact Us Form Submission on BookHub Marketplace</h2><p>Dear "+name+",</p><p>Thank you for contacting BookHub Marketplace. We appreciate you reaching out and taking the time to "+subject+".</p><p><strong>We have received your message regarding:</strong></p><p>"+message+"</p><p>A member of our customer support team will respond to your inquiry within 24 hours to the email address provided.</p><p>In the meantime, you may find answers to frequently asked questions by visiting our Help Center:<br>BookHub Help Center</a></p><p>We are committed to providing excellent customer service and appreciate your patience.</p><p>Sincerely,</p><p>The BookHub Marketplace Team</p></body>\r\n"
	      		+ "</html>"; 
	    		  
	    		  
	      

	        try {
	            send(recipient, sub, msg);
	            dispatcher = request.getRequestDispatcher("contacts.jsp?success=1");
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







