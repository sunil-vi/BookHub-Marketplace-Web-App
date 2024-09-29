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
<title>About us</title>
<%@ include file="includes/head.jsp"%>

</head>
<!-- Body-->
<body class="handheld-toolbar-enabled">

	<main class="page-wrapper">
		<!-- Navbar-->
		<%@ include file="includes/header.jsp"%>

		<main class="container-fluid px-0">
			
			<section class="row g-0">
				<div class="col-md-6 bg-position-center bg-size-cover bg-secondary"
					style="min-height: 15rem; background-image: url(img/about/01.jpg);"></div>
				<div class="col-md-6 px-3 px-md-5 py-5">
					<div class="mx-auto py-lg-5" style="max-width: 35rem;">
						<h2 class="h3 pb-3">Search, Select, Buy online</h2>
						<p class="fs-sm pb-3 text-muted">BookHub: Your premier online marketplace for books. Search easily, select from a vast range, and buy securely. Experience the joy of reading with just a few clicks.</p>
						<a class="btn btn-primary btn-shadow" href="marketplace-category.jsp">View
							Books</a>
					</div>
				</div>
			</section>


			<section class="row g-0">
				<div
					class="col-md-6 bg-position-center bg-size-cover bg-secondary order-md-2"
					style="min-height: 15rem; background-image: url(img/about/05.jpg);"></div>
				<div class="col-md-6 px-3 px-md-5 py-5 order-md-1">
					<div class="mx-auto py-lg-5" style="max-width: 35rem;">
						<h2 class="h3 pb-3">Growing Community</h2>
						<p class="fs-sm pb-3 text-muted">Join BookHub's growing community of book enthusiasts. Connect, share, and indulge in your passion for reading with like-minded individuals in our vibrant online space.</p>
						
					</div>
				</div>
			</section> 
			
			<section class="row g-0">
				<div class="col-md-6 bg-position-center bg-size-cover bg-secondary"
					style="min-height: 15rem; background-image: url(img/about/03.jpg);"></div>
				<div class="col-md-6 px-3 px-md-5 py-5">
					<div class="mx-auto py-lg-5" style="max-width: 35rem;">
						<h2 class="h3 pb-3">Read Online Anywhere </h2>
						<p class="fs-sm pb-3 text-muted">BookHub empowers you to read online anywhere. Dive into your favorite books on any device, anytime, ensuring a seamless and portable reading experience for all book lovers.</p>
						
					</div>
				</div>
			</section>
			<hr>
			<hr>
			<section
			class="bg-accent bg-size-cover bg-position-center pt-5 pb-4 pb-lg-5"
			style="background-image: url(img/marketplace/features/features-bg.jpg);">
			<div class="container pt-lg-3">
				<h2 class="h3 mb-3 pb-4 text-light text-center">Why our
					marketplace?</h2>
				<div class="row pt-lg-2 text-center">
					<div class="col-lg-3 col-sm-6 mb-grid-gutter">
						<div class="d-inline-flex align-items-center text-start">
							<img src="img/marketplace/features/quality.png" width="52"
								alt="Quality Guarantee">
							<div class="ps-3">
								<h6 class="text-light fs-base mb-1">Quality Guarantee</h6>
								<p class="text-light fs-ms opacity-70 mb-0">Quality checked
									by our team</p>
							</div>
						</div>
					</div>
					<div class="col-lg-3 col-sm-6 mb-grid-gutter">
						<div class="d-inline-flex align-items-center text-start">
							<img src="img/marketplace/features/support.png" width="52"
								alt="Customer Support">
							<div class="ps-3">
								<h6 class="text-light fs-base mb-1">Customer Support</h6>
								<p class="text-light fs-ms opacity-70 mb-0">Friendly 24/7
									customer support</p>
							</div>
						</div>
					</div>
					<div class="col-lg-3 col-sm-6 mb-grid-gutter">
						<div class="d-inline-flex align-items-center text-start">
							<img src="img/marketplace/features/updates.png" width="52"
								alt="Free Updates">
							<div class="ps-3">
								<h6 class="text-light fs-base mb-1">Lifetime Free Access</h6>
								<p class="text-light fs-ms opacity-70 mb-0">Never pay for an
									access</p>
							</div>
						</div>
					</div>
					<div class="col-lg-3 col-sm-6 mb-grid-gutter">
						<div class="d-inline-flex align-items-center text-start">
							<img src="img/marketplace/features/secure.png" width="52"
								alt="Secure Payments">
							<div class="ps-3">
								<h6 class="text-light fs-base mb-1">Secure Payments</h6>
								<p class="text-light fs-ms opacity-70 mb-0">We posess SSL /
									Secure сertificate</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
			
			
			
			
			<!-- Section: Team-->
			<section class="container py-3 py-lg-5 mt-4 mb-3">
				<h2 class="h3 my-2">Our core team</h2>
				<p class="fs-sm text-muted">People behind your great platform</p>
				<div class="row pt-3">
					<div class="col-lg-4 col-sm-6 mb-grid-gutter">
						<div class="d-flex align-items-center">
							<img class="rounded-circle" src="img/team/03.jpg" width="96"
								alt="Jonathan Doe">
							<div class="ps-3">
								<h6 class="fs-base pt-1 mb-1">Jonathan Doe</h6>
								<p class="fs-ms text-muted mb-0">CEO, Co-founder</p>
								<a class="nav-link-style fs-ms text-nowrap"
									href="mailto:johndoe@example.com"><i class="ci-mail me-2"></i>johndoe@example.com</a>
							</div>
						</div>
					</div>
					<div class="col-lg-4 col-sm-6 mb-grid-gutter">
						<div class="d-flex align-items-center">
							<img class="rounded-circle" src="img/team/04.jpg" width="96"
								alt="Barbara Palson">
							<div class="ps-3">
								<h6 class="fs-base pt-1 mb-1">Barbara Palson</h6>
								<p class="fs-ms text-muted mb-0">Chief of Marketing</p>
								<a class="nav-link-style fs-ms text-nowrap"
									href="mailto:b.palson@example.com"><i class="ci-mail me-2"></i>b.palson@example.com</a>
							</div>
						</div>
					</div>
					<div class="col-lg-4 col-sm-6 mb-grid-gutter">
						<div class="d-flex align-items-center">
							<img class="rounded-circle" src="img/team/06.jpg" width="96"
								alt="William Smith">
							<div class="ps-3">
								<h6 class="fs-base pt-1 mb-1">William Smith</h6>
								<p class="fs-ms text-muted mb-0">Financial director</p>
								<a class="nav-link-style fs-ms text-nowrap"
									href="mailto:w.smith@example.com"><i class="ci-mail me-2"></i>w.smith@example.com</a>
							</div>
						</div>
					</div>
					<div class="col-lg-4 col-sm-6 mb-grid-gutter">
						<div class="d-flex align-items-center">
							<img class="rounded-circle" src="img/team/02.jpg" width="96"
								alt="Amanda Gallaher">
							<div class="ps-3">
								<h6 class="fs-base pt-1 mb-1">Amanda Gallaher</h6>
								<p class="fs-ms text-muted mb-0">Lead UX designer</p>
								<a class="nav-link-style fs-ms text-nowrap"
									href="mailto:a.gallaher@example.com"><i
									class="ci-mail me-2"></i>a.gallaher@example.com</a>
							</div>
						</div>
					</div>
					<div class="col-lg-4 col-sm-6 mb-grid-gutter">
						<div class="d-flex align-items-center">
							<img class="rounded-circle" src="img/team/01.jpg" width="96"
								alt="Benjamin Miller">
							<div class="ps-3">
								<h6 class="fs-base pt-1 mb-1">Benjamin Miller</h6>
								<p class="fs-ms text-muted mb-0">Website development</p>
								<a class="nav-link-style fs-ms text-nowrap"
									href="mailto:b.miller@example.com"><i class="ci-mail me-2"></i>b.miller@example.com</a>
							</div>
						</div>
					</div>
					<div class="col-lg-4 col-sm-6 mb-grid-gutter">
						<div class="d-flex align-items-center">
							<img class="rounded-circle" src="img/team/07.jpg" width="96"
								alt="Miguel Rodrigez">
							<div class="ps-3">
								<h6 class="fs-base pt-1 mb-1">Miguel Rodrigez</h6>
								<p class="fs-ms text-muted mb-0">Content manager</p>
								<a class="nav-link-style fs-ms text-nowrap"
									href="mailto:b.miller@example.com"><i class="ci-mail me-2"></i>m.rodrigez@example.com</a>
							</div>
						</div>
					</div>
				</div>
			</section>
			
			<hr>
			
			
			
		</main>
	</main>
	<!-- Footer-->
	<%@ include file="includes/footer.jsp"%>

	<!-- Back To Top Button-->
	<a class="btn-scroll-top" href="#top" data-scroll><span
		class="btn-scroll-top-tooltip text-muted fs-sm me-2">Top</span><i
		class="btn-scroll-top-icon ci-arrow-up"> </i></a>
	<!-- Vendor scrits: js libraries and plugins-->
	<%@ include file="includes/vendorScripts.jsp"%>

</body>

</html>