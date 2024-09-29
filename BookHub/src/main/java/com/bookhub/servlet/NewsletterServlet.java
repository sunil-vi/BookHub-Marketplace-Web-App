package com.bookhub.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 * Servlet implementation class NewsletterServlet
 */
public class NewsletterServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static final String EMAIL_SENDER = "help050bookhub@gmail.com"; // Replace with your email
	private static final String EMAIL_PASSWORD = "zmgvqibyeeywayas"; // Replace with your password
	RequestDispatcher dispatcher;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NewsletterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String recipient = request.getParameter("recipient");
        
      String sub ="BookHub"; 
      String msg ="<!DOCTYPE html>\r\n"
      		+ "<html lang=\"en\">\r\n"
      		+ "<head>\r\n"
      		+ "  <meta charset=\"UTF-8\">\r\n"
      		+ "  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n"
      		+ "  <title>Welcome to the Bookhub Family!</title>\r\n"
      		+ "  <style>\r\n"
      		+ "    body {\r\n"
      		+ "      font-family: sans-serif;\r\n"
      		+ "      background-color: #f8f8f8;\r\n"
      		+ "      margin: 0;\r\n"
      		+ "      padding: 0;\r\n"
      		+ "    }\r\n"
      		+ "    .container {\r\n"
      		+ "      max-width: 600px;\r\n"
      		+ "      margin: 50px auto;\r\n"
      		+ "      background-color: #fff;\r\n"
      		+ "      padding: 30px;\r\n"
      		+ "      border-radius: 5px;\r\n"
      		+ "      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);\r\n"
      		+ "    }\r\n"
      		+ "    h1 {\r\n"
      		+ "      margin-top: 0;\r\n"
      		+ "      color: #333;\r\n"
      		+ "    }\r\n"
      		+ "    p {\r\n"
      		+ "      font-size: 16px;\r\n"
      		+ "      line-height: 1.5;\r\n"
      		+ "      color: #666;\r\n"
      		+ "    }\r\n"
      		+ "    a {\r\n"
      		+ "      color: #007bff;\r\n"
      		+ "      text-decoration: none;\r\n"
      		+ "    }\r\n"
      		+ "    a:hover {\r\n"
      		+ "      text-decoration: underline;\r\n"
      		+ "    }\r\n"
      		+ "  </style>\r\n"
      		+ "</head>\r\n"
      		+ "<body>\r\n"
      		+ "  <div class=\"container\">\r\n"
      		+ "    <h1>Welcome to Bookhub!</h1>\r\n"
      		+ "    <p>Thanks for subscribing to the Bookhub newsletter. We're thrilled to have you on board!</p>\r\n"
      		+ "    <p>Get ready to explore a world of literary delights delivered straight to your inbox. Here's what you can look forward to:</p>\r\n"
      		+ "    <ul>\r\n"
      		+ "      <li>Curated book recommendations based on your interests</li>\r\n"
      		+ "      <li>Exclusive deals and discounts on your favorite reads</li>\r\n"
      		+ "      <li>Early access to new releases and author interviews</li>\r\n"
      		+ "      <li>News and updates about the bookish world</li>\r\n"
      		+ "    </ul>\r\n"
      		+ "    <p>We hope you'll love staying connected with Bookhub. Happy reading!</p>\r\n"
      		+ "    <p>In the meantime, check out our amazing selection of books on the Bookhub Marketplace.</p>\r\n"
      		+ "  </div>\r\n"
      		+ "</body>\r\n"
      		+ "</html>\r\n"
      		+ "";
    		  
    		  
      

        try {
            send(recipient, sub, msg);
            dispatcher = request.getRequestDispatcher("index.jsp?news=1");
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
