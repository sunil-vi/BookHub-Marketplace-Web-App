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
  <title>Contacts</title>
  <%@ include file="includes/head.jsp" %>  
  </head>
  <!-- Body-->
  <body class="handheld-toolbar-enabled">
  <%
	String success = (String) request.getParameter("success");
	if (success != null && success.equals("1")) {
	%>

	<!-- Success alert -->
	<div class="alert alert-success alert-dismissible fade show"
		role="alert">
		<span class="fw-medium">Thanks </span>for contating us .
		<button type="button" class="btn-close" data-bs-dismiss="alert"
			aria-label="Close"></button>
	</div>
	<%
	} 
	%>
  
    
    <main class="page-wrapper">
    <!-- Navbar-->
<%@ include file="includes/header.jsp" %>
      <!-- Page Title (Light)-->
      <div class="bg-secondary py-4">
        <div class="container d-lg-flex justify-content-between py-2 py-lg-3">
          <div class="order-lg-2 mb-3 mb-lg-0 pt-lg-2">
            <nav aria-label="breadcrumb">
              <ol class="breadcrumb flex-lg-nowrap justify-content-center justify-content-lg-start">
                <li class="breadcrumb-item"><a class="text-nowrap" href="index.html"><i class="ci-home"></i>Home</a></li>
                <li class="breadcrumb-item text-nowrap active" aria-current="page">Contacts</li>
              </ol>
            </nav>
          </div>
          <div class="order-lg-1 pe-lg-4 text-center text-lg-start">
            <h1 class="h3 mb-0">Contacts</h1>
          </div>
        </div>
      </div>
      <!-- Contact detail cards-->
      <section class="container-fluid pt-grid-gutter">
        <div class="row">
          <div class="col-xl-3 col-sm-6 mb-grid-gutter"><a class="card h-100" href="#map" data-scroll>
              <div class="card-body text-center"><i class="ci-location h3 mt-2 mb-4 text-primary"></i>
                <h3 class="h6 mb-2">Main store address</h3>
                <p class="fs-sm text-muted">Sundarnagar, Mangadewadi Katraj Pune</p>
                <div class="fs-sm text-primary">Click to see map<i class="ci-arrow-right align-middle ms-1"></i></div>
              </div></a></div>
          <div class="col-xl-3 col-sm-6 mb-grid-gutter">
            <div class="card h-100">
              <div class="card-body text-center"><i class="ci-time h3 mt-2 mb-4 text-primary"></i>
                <h3 class="h6 mb-3">Working hours</h3>
                <ul class="list-unstyled fs-sm text-muted mb-0">
                  <li>Mon - Fri: 10AM - 7PM</li>
                  <li class="mb-0">Sat: 11AM - 5PM</li>
                </ul>
              </div>
            </div>
          </div>
          <div class="col-xl-3 col-sm-6 mb-grid-gutter">
            <div class="card h-100">
              <div class="card-body text-center"><i class="ci-phone h3 mt-2 mb-4 text-primary"></i>
                <h3 class="h6 mb-3">Phone numbers</h3>
                <ul class="list-unstyled fs-sm mb-0">
                  <li><span class="text-muted me-1">For customers:</span><a class="nav-link-style" href="tel:+108044357260">+91 9890137658</a></li>
                  <li class="mb-0"><span class="text-muted me-1">Tech support:</span><a class="nav-link-style" href="tel:+100331697720">+91 9890137658</a></li>
                </ul>
              </div>
            </div>
          </div>
          <div class="col-xl-3 col-sm-6 mb-grid-gutter">
            <div class="card h-100">
              <div class="card-body text-center"><i class="ci-mail h3 mt-2 mb-4 text-primary"></i>
                <h3 class="h6 mb-3">Email addresses</h3>
                <ul class="list-unstyled fs-sm mb-0">
                  <li><span class="text-muted me-1">For customers:</span><a class="nav-link-style" href="mailto:+108044357260">help050bookhub@gmail.com</a></li>
                  <li class="mb-0"><span class="text-muted me-1">Tech support:</span><a class="nav-link-style" href="mailto:support@example.com">help050bookhub@gmail.com</a></li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </section>
     
     
      <!-- Split section: Map + Contact form-->
      <div class="container-fluid px-0" id="map">
        <div class="row g-0">
          <div class="col-lg-6 iframe-full-height-wrap">
            <iframe class="iframe-full-height" width="600" height="250" src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d15139.476960092801!2d73.85238021473414!3d18.444245222151164!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3bc2eac101655f87%3A0xcc5b0a20d60c9ac8!2sKatraj%2C%20Pune%2C%20Maharashtra!5e0!3m2!1sen!2sin!4v1711968445354!5m2!1sen!2sin" ></iframe>
          
          
          </div>
          <div class="col-lg-6 px-4 px-xl-5 py-5 border-top">
            <h2 class="h4 mb-4">Drop us a line</h2>
            <form class="needs-validation mb-3" action="SendMailServlet" method="get" novalidate>
              <div class="row g-3">
                <div class="col-sm-6">
                  <label class="form-label" for="cf-name">Your name:&nbsp;<span class="text-danger">*</span></label>
                  <input class="form-control" type="text" id="cf-name" placeholder="Enter name" name="name" required>
                  <div class="invalid-feedback">Please fill in you name!</div>
                </div>
                <div class="col-sm-6">
                  <label class="form-label" for="cf-email">Email address:&nbsp;<span class="text-danger">*</span></label>
                  <input class="form-control" type="email" id="cf-email" placeholder="Enter email" name="recipient" required>
                  <div class="invalid-feedback">Please provide valid email address!</div>
                </div>
                <div class="col-sm-6">
                  <label class="form-label" for="cf-phone">Your phone:&nbsp;<span class="text-danger">*</span></label>
                  <input class="form-control" type="text" id="cf-phone" placeholder="Enter Phone nuber" name="phone" required>
                  <div class="invalid-feedback">Please provide valid phone number!</div>
                </div>
                <div class="col-sm-6">
                  <label class="form-label" for="cf-subject">Subject:</label>
                  <input class="form-control" type="text" id="cf-subject" placeholder="Provide short title of your request" name="subject">
                </div>
                <div class="col-12">
                  <label class="form-label" for="cf-message">Message:&nbsp;<span class="text-danger">*</span></label>
                  <textarea class="form-control" id="cf-message" rows="6" placeholder="Please describe in detail your request" name="message" required></textarea>
                  <div class="invalid-feedback">Please write a message!</div>
                  <button class="btn btn-primary mt-4" type="submit">Send message</button>
                </div>
              </div>
            </form>
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