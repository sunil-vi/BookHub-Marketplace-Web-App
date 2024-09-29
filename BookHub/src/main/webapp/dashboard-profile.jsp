<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*,java.util.*,java.text.DecimalFormat"%>
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

ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Profile</title>
    <%@ include file="includes/head.jsp"%>
  </head>
  <!-- Body-->
  <body class="handheld-toolbar-enabled">
  <%
	String success = (String)request.getParameter("success");
	String error = (String)request.getParameter("error");
	if (success !=null && success.equals("1") ) {
%>
		<!-- Success alert -->
		<div class="alert alert-success alert-dismissible fade show"
			role="alert">
			<span class="fw-medium">Profile</span> updated successfully.
			<button type="button" class="btn-close" data-bs-dismiss="alert"
				aria-label="Close"></button>
		</div>
<%	
} else if (error!=null && error.equals("1")) {
%>
<!-- Danger alert -->
	<div class="alert alert-danger alert-dismissible fade show"
		role="alert">
		<span class="fw-medium">Profile Update</span> failed. Try Again.
		<button type="button" class="btn-close" data-bs-dismiss="alert"
			aria-label="Close"></button>
	</div>
<%} else if (error != null && error.equals("6")) { %>
	
		<div class="alert alert-danger alert-dismissible fade show"
		role="alert">
		<span class="fw-medium">Password must have:</span>at least one digit,lower case letter,upper case letter,special character.<br>and at least 8 characters in length No whitespaces.
		<button type="button" class="btn-close" data-bs-dismiss="alert"
			aria-label="Close"></button>
	</div>
	<%} %>

    
   
    <main class="page-wrapper">
      
      <!-- Navbar Marketplace-->
      <%@ include file="includes/header.jsp" %>
      <!-- Dashboard header-->
      <%@ include file="includes/dashboard-header.jsp" %>
      
      <div class="container mb-5 pb-3">
        <div class="bg-light shadow-lg rounded-3 overflow-hidden">
          <div class="row">
            <!-- Sidebar-->
            <%@ include file="includes/sidebar.jsp" %>
            <!-- Content-->
            <section class="col-lg-8 pt-lg-4 pb-4 mb-3">
              <div class="pt-2 px-4 ps-lg-0 pe-xl-5">
                <h2 class="h3 py-2 text-center text-sm-start">Profile</h2>
                <!-- Tabs-->
                <ul class="nav nav-tabs nav-justified" role="tablist">
                  <li class="nav-item"><a class="nav-link px-0 active" href="#profile" data-bs-toggle="tab" role="tab">
                      <div class="d-none d-lg-block"><i class="ci-user opacity-60 me-2"></i>Profile</div>
                      <div class="d-lg-none text-center"><i class="ci-user opacity-60 d-block fs-xl mb-2"></i><span class="fs-ms">Profile</span></div></a></li>
                  
                </ul>
                
                <div class="tab-content">
                  <!-- Profile-->
                  <div class="tab-pane fade show active" id="profile" role="tabpanel">
                    <form action="UpdateProfileServlet" method="POST" enctype="multipart/form-data">
                    <div class="bg-secondary rounded-3 p-4 mb-4">
                      <div class="d-flex align-items-center"><img class="rounded" src="assets/uimages/<%=user.getImage()%>" width="90" alt="USER">
                        <div class="ps-3">
                        
                          <input id="unp-product-files" type="file" name="uimage" > 
                          <div class="p mb-0 fs-ms text-muted">Upload JPG, GIF or PNG image. 300 x 300 required.</div>
                        </div>
                      </div>
                    </div>
                    <div class="row gx-4 gy-3">
                      <div class="col-sm-6">
                        <label class="form-label" for="dashboard-fn">First Name</label>
                        <input class="form-control" type="text" id="dashboard-fn" value="" name="fname" placeholder="<%=user.getFname()%>" required>
                      </div>
                      <div class="col-sm-6">
                        <label class="form-label" for="dashboard-ln">Last Name</label>
                        <input class="form-control" type="text" id="dashboard-ln" value="" name="lname" placeholder="<%=user.getLname()%>" required>
                      </div>
                      <div class="col-sm-6">
                        <label class="form-label" for="dashboard-email">Email address</label>
                        <input class="form-control" type="email" id="dashboard-email" value="" name="email" placeholder="<%=user.getEmail()%>" required>
                      </div>
                      
                      <div class="col-sm-6">
                        <label class="form-label" for="dashboard-address">Address</label>
                        <input class="form-control" type="text" id="dashboard-address" value="" name="addr" placeholder="<%=user.getAddress()%>" required>
                      </div>
                      <div class="col-sm-6">
                        <label class="form-label" for="dashboard-city">Phone</label>
                        <input class="form-control" type="number" id="dashboard-city" value="" name="phno" placeholder="<%=user.getPhno()%>" required >
                      </div>
                      <div class="col-sm-6">
                        <label class="form-label" for="dashboard-password">Password</label>
                        <input class="form-control" type="password" id="dashboard-password" name="password" required>
                      </div>
                      <div class="col-sm-6">
                        <label class="form-label" for="dashboard-pass"> Confirm Password</label>
                        <input class="form-control" type="password" id="dashboard-password" name="cpassword" required>
                      </div>
                      <div class="col-12">
                        <hr class="mt-2 mb-4">
                        <div class="d-sm-flex justify-content-between align-items-center">
                         
                          <button class="btn btn-primary mt-3 mt-sm-0" type="submit" >Save changes</button>
                        </div>
                      </div>
                    </div>
                  </form>
                  </div>
                </div>
              </div>
                
            </section>
          </div>
        </div>
      </div>
    </main>
    <!-- Footer-->
    <%@ include file="includes/footer.jsp" %>
	
	<!-- Back To Top Button--><a class="btn-scroll-top" href="#top" data-scroll><span class="btn-scroll-top-tooltip text-muted fs-sm me-2">Top</span><i class="btn-scroll-top-icon ci-arrow-up">   </i></a>
    <!-- Vendor scrits: js libraries and plugins-->
    <%@ include file="includes/vendorScripts.jsp" %>
  </body>

</html>