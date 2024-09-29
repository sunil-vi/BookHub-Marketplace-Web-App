<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*,java.util.*"%>
<%@ page import="com.bookhub.util.*" %>
<%@ page import="com.bookhub.dao.*" %>
<%
// Retrieve the session object
HttpSession session1 = request.getSession(false);
User user;
// Check if the session is not null and the user attribute is set
if (session1.getAttribute("user") != null) {
	user = (User)session.getAttribute("user");
	
} else {
	user = null;
	
}
//BookDao bd = new BookDao(DBUtil.getConnection());
//List<Book> books = bd.getAllBooks();

ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");

%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Password Recovery</title>
<%@ include file="includes/head.jsp"%>

</head>
<!-- Body-->

<body class="handheld-toolbar-enabled">

  <main class="page-wrapper">
  <%
	String passEmail = (String) request.getParameter("passEmail");
	if (passEmail != null && passEmail.equals("success")) {
	%>

	<!-- Success alert -->
	<div class="alert alert-success alert-dismissible fade show"
		role="alert">
		<span class="fw-medium">Email Sent</span> Successfully.
		<button type="button" class="btn-close" data-bs-dismiss="alert"
			aria-label="Close"></button>
	</div>
	<%
	}
	%>
	<% 	
	String error= (String) request.getParameter("error");
	if (error != null && error.equals("1")) {
	%>

	<!-- Danger alert -->
	<div class="alert alert-danger alert-dismissible fade show"
		role="alert">
		<span class="fw-medium">No User</span> Found.
		<button type="button" class="btn-close" data-bs-dismiss="alert"
			aria-label="Close"></button>
	</div>
	<%
	}
	%>
    <!-- Navbar-->
		<%@ include file="includes/header.jsp" %>
	

    <div class="container py-4 py-lg-5 my-4">
      <div class="row justify-content-center">
        <div class="col-lg-8 col-md-10">
          <h2 class="h3 mb-4">Forgot your password?</h2>
          <p class="fs-md">Change your password in three easy steps. This helps to keep your new password secure.</p>
          <ol class="list-unstyled fs-md">
            <li><span class="text-primary me-2">1.</span>Fill in your email address below.</li>
            <li><span class="text-primary me-2">2.</span>We'll email you a temporary password.</li>
            <li><span class="text-primary me-2">3.</span>Use it to change your password on our secure website.
            </li>
          </ol>
          <div class="card py-2 mt-4">
            <form class="card-body needs-validation" action="RecoveryServlet" method="post" novalidate>
              <div class="mb-3">
                <label class="form-label" for="recover-email">Enter your email address</label>
                <input class="form-control" type="email" id="recover-email" name="email" required>
                <div class="invalid-feedback">Please provide valid email address.</div>
              </div>
              <button class="btn btn-primary" type="submit">Get new password</button>
            </form>
          </div>
        </div>
      </div>
    </div>
  </main>
  <!-- Footer-->
  <%@ include file="includes/footer.jsp" %>

  
  <!-- Back To Top Button--><a class="btn-scroll-top" href="#top" data-scroll><span
      class="btn-scroll-top-tooltip text-muted fs-sm me-2">Top</span><i class="btn-scroll-top-icon ci-arrow-up">
    </i></a>
  <!-- Vendor scrits: js libraries and plugins-->
	<%@ include file="includes/vendorScripts.jsp" %>

</body>

</html>