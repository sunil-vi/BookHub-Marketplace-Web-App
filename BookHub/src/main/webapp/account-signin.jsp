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
<title>Account Sign In</title>

<%@ include file="includes/head.jsp"%>
</head>

<!-- Body-->

<body class="handheld-toolbar-enabled">


	<%
	String registration = (String) request.getParameter("registration");
	if (registration != null && registration.equals("success")) {
	%>

	<!-- Success alert -->
	<div class="alert alert-success alert-dismissible fade show"
		role="alert">
		<span class="fw-medium">Sign up:</span> Successful Please sign in.
		<button type="button" class="btn-close" data-bs-dismiss="alert"
			aria-label="Close"></button>
	</div>
	<%
	}
	%>

	<%
	String error = (String) request.getParameter("error");
	if (error != null && error.equals("1")) {
	%>

	<!-- Danger alert -->
	<div class="alert alert-danger alert-dismissible fade show"
		role="alert">
		<span class="fw-medium">Sign up:</span> failed Try again.
		<button type="button" class="btn-close" data-bs-dismiss="alert"
			aria-label="Close"></button>
	</div>
	<%
	} else if (error != null && error.equals("2")) {
	//String error3 = (String) request.getParameter("error");
	%>
	<!-- Danger alert -->
	<div class="alert alert-danger alert-dismissible fade show"
		role="alert">
		<span class="fw-medium">Login</span> failed Try again.
		<button type="button" class="btn-close" data-bs-dismiss="alert"
			aria-label="Close"></button>
	</div>


	<%
	}
	//String error4 = (String) request.getParameter("error");
	else if (error != null && error.equals("4")) {
	%>

	<!-- Danger alert -->
	<div class="alert alert-danger alert-dismissible fade show"
		role="alert">
		<span class="fw-medium">User</span> already present.
		<button type="button" class="btn-close" data-bs-dismiss="alert"
			aria-label="Close"></button>
	</div>
	<%
	}else if (error != null && error.equals("5")) {
	%>
		<div class="alert alert-danger alert-dismissible fade show"
		role="alert">
		<span class="fw-medium">Email must </span>be in format abc123@abc.
		<button type="button" class="btn-close" data-bs-dismiss="alert"
			aria-label="Close"></button>
	</div>
	<%}else if (error != null && error.equals("6")) { %>
	
		<div class="alert alert-danger alert-dismissible fade show"
		role="alert">
		<span class="fw-medium">Password must have:</span> At least one digit,lower case letter,upper case letter,special character.<br>and at least 8 characters in length No whitespaces.
		<button type="button" class="btn-close" data-bs-dismiss="alert"
			aria-label="Close"></button>
	</div>
	<%}	else if (error != null && error.equals("8")) { %>
	
	<div class="alert alert-danger alert-dismissible fade show"
	role="alert">
	<span class="fw-medium">Please Sign</span>in first.
	<button type="button" class="btn-close" data-bs-dismiss="alert"
		aria-label="Close"></button>
</div>
<%} %>
	
	
	<main class="page-wrapper">
		<!-- navbar -->
		<%@ include file="includes/header.jsp"%>
		
		<div class="container py-4 py-lg-5 my-4">
			<div class="row">
				<div class="col-md-6">
					<div class="card border-0 shadow">
						<div class="card-body">
							<h2 class="h4 mb-1">Sign in</h2>
							<div class="py-3">
								<h3
									class="d-inline-block align-middle fs-base fw-medium mb-2 me-2">With
									created account here</h3>
								<!-- <div class="d-inline-block align-middle "><a class="btn-social bs-google me-2 mb-2" href="#" data-bs-toggle="tooltip" title="Sign in with Google"><i class="ci-google"></i></a><a class="btn-social bs-facebook me-2 mb-2" href="#" data-bs-toggle="tooltip" title="Sign in with Facebook"><i class="ci-facebook"></i></a><a class="btn-social bs-twitter me-2 mb-2" href="#" data-bs-toggle="tooltip" title="Sign in with Twitter"><i class="ci-twitter"></i></a></div> -->
							</div>
							<hr>
							<h3 class="fs-base pt-4 pb-2">using form below</h3>
							<form class="needs-validation" novalidate method="POST"
								action="LoginServlet">
								<div class="input-group mb-3">
									<i
										class="ci-mail position-absolute top-50 translate-middle-y text-muted fs-base ms-3"></i>
									<input class="form-control rounded-start" type="email"
										placeholder="Email" required name="email">
								</div>
								<div class="input-group mb-3">
									<i
										class="ci-locked position-absolute top-50 translate-middle-y text-muted fs-base ms-3"></i>
									<div class="password-toggle w-100">
										<input class="form-control" type="password"
											placeholder="Password" required name="password"> <label
											class="password-toggle-btn" aria-label="Show/hide password">
											<input class="password-toggle-check" type="checkbox"><span
											class="password-toggle-indicator"></span>
										</label>
									</div>
								</div>
								<div class="d-flex flex-wrap justify-content-between">
									<div class="form-check">
										<input class="form-check-input" type="checkbox" checked
											id="remember_me"> <label class="form-check-label"
											for="remember_me">Remember me</label>
									</div>
									<a class="nav-link-inline fs-sm"
										href="account-password-recovery.jsp">Forgot password?</a>
								</div>
								<hr class="mt-4">
								<div class="text-end pt-4">
									<button class="btn btn-primary" type="submit">
										<i class="ci-sign-in me-2 ms-n21"></i>Sign In
									</button>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="col-md-6 pt-4 mt-3 mt-md-0">
					<h2 class="h4 mb-3">No account? Sign up</h2>
					<p class="fs-sm text-muted mb-4">Registration takes less than a
						minute but gives you full control over your orders.</p>
					<form class="needs-validation" novalidate method="POST"
						action="RegisterServlet">
						<div class="row gx-4 gy-3">
							<div class="col-sm-6">
								<label class="form-label" for="reg-fn">First Name</label> <input
									class="form-control" type="text" required id="reg-fn"
									name="fname">
								<div class="invalid-feedback">Please enter your first
									name!</div>
							</div>
							<div class="col-sm-6">
								<label class="form-label" for="reg-ln">Last Name</label> <input
									class="form-control" type="text" required id="reg-ln"
									name="lname">
								<div class="invalid-feedback">Please enter your last name!</div>
							</div>
							<div class="col-sm-6">
								<label class="form-label" for="reg-email">E-mail Address</label>
								<input class="form-control" type="email" required id="reg-email"
									name="email">
								<div class="invalid-feedback">Please enter valid email
									address!</div>
							</div>
							<div class="col-sm-6">
								<label class="form-label" for="reg-phone">Phone Number</label> <input
									class="form-control" type="number" required id="reg-phone"
									name="phno" maxlength="10">
								<div class="invalid-feedback">Please enter your phone
									number!</div>
							</div>
							<div class="col-sm-6">
								<label class="form-label" for="reg-password">Password</label> <input
									class="form-control" type="password" required id="reg-password"
									name="password">
								<div class="invalid-feedback">Please enter password!</div>
							</div>
							<div class="col-sm-6">
								<label class="form-label" for="reg-password-confirm">Confirm
									Password</label> <input class="form-control" type="password" required
									id="reg-password-confirm" name="cpassword">
								<div class="invalid-feedback">Passwords do not match!</div>
							</div>
							<div class="col-12 text-end">
								<button class="btn btn-primary" type="submit">
									<i class="ci-user me-2 ms-n1"></i>Sign Up
								</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</main>



	<!-- 	footer -->
	<%@ include file="includes/footer.jsp"%>

	<!-- Back To Top Button-->
	<a class="btn-scroll-top" href="#top" data-scroll><span
		class="btn-scroll-top-tooltip text-muted fs-sm me-2">Top</span><i
		class="btn-scroll-top-icon ci-arrow-up"> </i></a>
	<!-- Vendor scrits: js libraries and plugins-->
	<%@ include file="includes/vendorScripts.jsp" %>
</body>


</html>