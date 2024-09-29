package com.bookhub.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.bookhub.util.DBUtil;
import com.bookhub.util.EmailPassUtil;
import com.bookhub.dao.*;

/**
 * Servlet implementation class UpdateProfileServlet
 */
@MultipartConfig
public class UpdateProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	RequestDispatcher dispatcher;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateProfileServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// code to upload image
				Part uimage = request.getPart("uimage"); // to get image of book
				String imageFileName = uimage.getSubmittedFileName(); // get image name

				String uploadPath = "C:/Users/10x Discipline/eclipse-workspace/BookHub/src/main/webapp/assets/uimages/" + imageFileName;
//				System.out.println(imageFileName);

				try {

					// to copy uploding image into bimages folder
					FileOutputStream fos = new FileOutputStream(uploadPath); // open image file where it is going to upload  

					InputStream is = uimage.getInputStream(); //convert into stream selected image
					byte[] data = new byte[is.available()]; 
					is.read(data); //copy image stream

					fos.write(data); // write in the uploading iamge path file
//					System.out.println("Successfully uploaded");
				} catch (Exception e) {
					e.printStackTrace();
					dispatcher = request.getRequestDispatcher("dashboard-profile.jsp?error=1");
					dispatcher.forward(request, response);
				}
//===================================================================================
		  //upload book data into database s
				HttpSession session = request.getSession(false);
				User user = (User) session.getAttribute("user");
				String pass = null;
				
				String fname= request.getParameter("fname");
		        String lname= request.getParameter("lname");
		        String email = request.getParameter("email");
		        String phno = request.getParameter("phno");
		        String addr = request.getParameter("addr");
		        
		        String password= request.getParameter("password");
		        String cpass = request.getParameter("cpassword");
		        if(cpass.equals(password) && EmailPassUtil.isPass(password))
		        {
		        	pass = EmailPassUtil.encrypt(password);
		        }else {
		        	dispatcher = request.getRequestDispatcher("dashboard-profile.jsp?error=6");
		        	dispatcher.forward(request, response);

		        }
			
			
			
			
			String query = "UPDATE user SET fname = ?, lname = ?, email = ?, phno = ?, password = ?, image = ?, address = ? WHERE id=?"; 

			try (Connection connection = DBUtil.getConnection();
					PreparedStatement preparedStatement = connection.prepareStatement(query);) {
				
				preparedStatement.setString(1, fname);
				preparedStatement.setString(2, lname);
				preparedStatement.setString(3, email);
				preparedStatement.setString(4, phno);
				preparedStatement.setString(5, pass);
				preparedStatement.setString(6, imageFileName);
				preparedStatement.setString(7, addr);
				preparedStatement.setInt(8, user.getId());
				
				
				int rows = preparedStatement.executeUpdate();

				if (rows > 0) {
					//dispatcher = request.getRequestDispatcher("dashboard-profile.jsp?success=1");
					//dispatcher.forward(request, response);
					response.sendRedirect("account-signin.jsp");			
				}
				
				else {
					dispatcher = request.getRequestDispatcher("dashboard-profile.jsp?error=1");
					dispatcher.forward(request, response);
				}

			} catch (SQLException e) {
				e.printStackTrace();
				dispatcher = request.getRequestDispatcher("dashboard-profile.jsp?error=1");
				dispatcher.forward(request, response);
			}
		    
		
}

}
