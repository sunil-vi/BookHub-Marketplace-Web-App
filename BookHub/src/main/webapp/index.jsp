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
<title>BookHub</title>
<%@ include file="includes/head.jsp"%>
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
		<span class="fw-medium">Sign in:</span> Successful .
		<button type="button" class="btn-close" data-bs-dismiss="alert"
			aria-label="Close"></button>
	</div>
	<%
	} else if (success != null && success.equals("2")){
	%>
	<!-- Success alert -->
	<div class="alert alert-success alert-dismissible fade show"
		role="alert">
		<span class="fw-medium">Book</span> added to the cart .
		<button type="button" class="btn-close" data-bs-dismiss="alert"
			aria-label="Close"></button>
	</div>
	<%} %>
	
	<%
	String error = (String) request.getParameter("error");
	if (error != null && error.equals("1")) {
	%>

	<!-- Danger alert -->
	<div class="alert alert-danger alert-dismissible fade show"
		role="alert">
		<span class="fw-medium">Book</span> already present in cart.
		<button type="button" class="btn-close" data-bs-dismiss="alert"
			aria-label="Close"></button>
	</div>
	<%
	} 
	%>
<%
	String news = (String) request.getParameter("news");
	if (news != null && news.equals("1")) {
	%>

	<!-- Success alert -->
	<div class="alert alert-success alert-dismissible fade show"
		role="alert">
		<span class="fw-medium">Successfully</span> subscribed.
		<button type="button" class="btn-close" data-bs-dismiss="alert"
			aria-label="Close"></button>
	</div>
	<%
	} 
	%>

	<main class="page-wrapper">
		<!-- Navbar Marketplace-->
		<%@ include file="includes/header.jsp" %>
		
		<!-- Hero section-->
		<section class="bg-accent bg-position-top-center bg-repeat-0 py-5" style="background-image: url(img/home/hero.png);">
			<div class="pb-lg-5 mb-lg-3">
				<div class="container py-lg-5 my-lg-5">
					<div class="row mb-4 mb-sm-5">
						<div class="col-lg-7 col-md-9 text-center text-sm-start">
							<h1 class="text-white lh-base"> 
								<span class='fw-light'>BookHub:</span> Unleash<span class='fw-light'> Curiosity,</span>
								Ignite <span class='fw-light'>Imagination,</span> Inspire <span class='fw-light'>Growth</span>
								
							</h1>
							<h2 class="h5 text-white fw-light">Well Researched books
								created by our global community</h2>
						</div>
					</div>
					   
					
					
				</div>
			</div>
		</section>

		<!-- Featured books (Carousel)-->
		<section
			class="container position-relative pt-3 pt-lg-0 pb-5 mt-lg-n10"
			style="z-index: 10;">
			<div class="card px-lg-2 border-0 shadow-lg">
				<div class="card-body px-4 pt-5 pb-4">
					<h2 class="h3 text-center">Discover featured Books</h2>
					<p class="text-muted text-center">Every week we hand-pick some
						of the best books from our collection</p>
					<!-- Carousel-->
					<div class="tns-carousel pt-4">
						<div class="tns-carousel-inner"
							data-carousel-options="{&quot;items&quot;: 2, &quot;gutter&quot;: 15, &quot;controls&quot;: false, &quot;nav&quot;: true, &quot;responsive&quot;: {&quot;0&quot;:{&quot;items&quot;:1},&quot;500&quot;:{&quot;items&quot;:2},&quot;768&quot;:{&quot;items&quot;:3}, &quot;992&quot;:{&quot;items&quot;:3, &quot;gutter&quot;: 30}}}">

							<%
							try {
								Connection conn = DBUtil.getConnection();
								Statement st = conn.createStatement();
								ResultSet rs1 = st.executeQuery("SELECT * FROM books ORDER BY 1  LIMIT 0,4");
								while (rs1.next()) { 
									//for (Book b: books) {
							%>

							<!-- Book-->
							<div>
								<div class="card product-card-alt">
									<div class="product-thumb">

										<div class="product-card-actions">
											<a class="btn btn-light btn-icon btn-shadow fs-base mx-2"
												href="marketplace-single.jsp?id=<%=rs1.getInt("id")%>"><i class="ci-eye"></i></a>
											<a class="btn btn-light btn-icon btn-shadow fs-base mx-2" href="CartServlet?id=<%=rs1.getInt("id") %>">
												<i class="ci-cart"></i>
											</a>
										</div>
										<a class="product-thumb-overlay" href=" marketplace-single.jsp?id=<%=rs1.getInt("id")%>"></a><img
											src="assets/bimages/<%=rs1.getString("image")%>"
											alt="<%=rs1.getString("image")%>" style="height: 500px; object-fit: cover;">
									</div>

									<div class="card-body">
										<div
											class="d-flex flex-wrap justify-content-between align-items-start pb-2">
											<div class="text-muted fs-xs me-1">
												by <a class="product-meta fw-medium" href="#"><%=rs1.getString("author")%>
												</a>in <a class="product-meta fw-medium" href="#"><%=rs1.getString("cat_name")%></a>
											</div>
											<div class="star-rating">
												<i class="star-rating-icon ci-star-filled active"></i><i
													class="star-rating-icon ci-star-filled active"></i><i
													class="star-rating-icon ci-star-filled active"></i><i
													class="star-rating-icon ci-star-filled active"></i><i
													class="star-rating-icon ci-star-filled active"></i>
											</div>
										</div>

										<h3 class="product-title fs-sm mb-2">
											<a href=" marketplace-single.jsp?<%=rs1.getInt("id") %>"><%=rs1.getString("bname")%></a>
										</h3>
										<div
											class="d-flex flex-wrap justify-content-between align-items-center">
											<div class="fs-sm me-2">
												<i class="ci-download text-muted me-1"></i><%=rs1.getString("bsold")%><span
													class="fs-xs ms-1">Sales</span>
											</div>
											<div class="bg-faded-accent text-accent rounded-1 py-1 px-2">
												&#8377 <%=rs1.getString("price")%>.<small>00</small>
											</div>
										</div>
									</div>
								</div>
							</div>
							<%
							}
							} catch (Exception e) {
							e.printStackTrace();
							}
							%>

						</div>
					</div>
				</div>
			</div>
		</section>

		<!-- Recent products grid-->
		<section class="container pb-5 mb-lg-3">
			<!-- Heading-->
			<div
				class="d-flex flex-wrap justify-content-between align-items-center pt-1 border-bottom pb-4 mb-4">
				<h2 class="h3 mb-0 pt-3 me-2">The most recent releases</h2>
				
			</div>
			<!-- Grid-->
			<div class="row pt-2 mx-n2">
				<%
				try {
					Connection conn = DBUtil.getConnection();
					Statement st = conn.createStatement();
					ResultSet rs2 = st.executeQuery("SELECT * FROM books ORDER BY 1  DESC LIMIT 0,7");
					while (rs2.next()) {
				%>
				<!-- Book-->
				<div class="col-lg-3 col-md-4 col-sm-6 px-2 mb-grid-gutter">
					<!-- Book-->
					<div class="card product-card-alt">
						<div class="product-thumb">

							<div class="product-card-actions">
								<a class="btn btn-light btn-icon btn-shadow fs-base mx-2"
									href=" marketplace-single.jsp?id=<%=rs2.getInt("id")%>"><i class="ci-eye"></i></a>
								<a class="btn btn-light btn-icon btn-shadow fs-base mx-2"
									href="CartServlet?id=<%=rs2.getInt("id")%>">
									<i class="ci-cart"></i>
								</a>
							</div>
							<a class="product-thumb-overlay" href=" marketplace-single.jsp?id=<%=rs2.getInt("id")%>"></a><img
								src="assets/bimages/<%=rs2.getString("image")%>"
								alt="<%=rs2.getString("image")%>" style="height: 500px; object-fit: cover;">
						</div>
						<div class="card-body">
							<div
								class="d-flex flex-wrap justify-content-between align-items-start pb-2">
								<div class="text-muted fs-xs me-1">
									by <a class="product-meta fw-medium" href="#"> <%=rs2.getString("author")%>.
									</a>in <a class="product-meta fw-medium" href="#"><%=rs2.getString("cat_name")%></a>
								</div>
								<div class="star-rating">
									<i class="star-rating-icon ci-star-filled active"></i><i
										class="star-rating-icon ci-star-filled active"></i><i
										class="star-rating-icon ci-star-filled active"></i><i
										class="star-rating-icon ci-star-half active"></i><i
										class="star-rating-icon ci-star"></i>
								</div>
							</div>
							<h3 class="product-title fs-sm mb-2">
								<a href=" marketplace-single.jsp?id=<%=rs2.getInt("id")%>"><%=rs2.getString("bname")%></a>
							</h3>
							<div
								class="d-flex flex-wrap justify-content-between align-items-center">
								<div class="fs-sm me-2">
									<i class="ci-download text-muted me-1"></i><%=rs2.getString("bsold")%><span
										class="fs-xs ms-1">Sales</span>
								</div>
								<div class="bg-faded-accent text-accent rounded-1 py-1 px-2">
									&#8377
									<%=rs2.getString("price")%>.<small>00</small>
								</div>
							</div>
						</div>
					</div>
				</div>

				<%
				}
				} catch (Exception e) {
				e.printStackTrace();
				}
				%>
			</div>

			<!-- More button-->
			<div class="text-center">
				<a class="btn btn-outline-accent" href=" marketplace-category.jsp">View
					more Books<i class="ci-arrow-right fs-ms ms-1"></i>
				</a>
			</div>
		</section>

		<!-- Seller of the month-->
		<section class="border-top py-5">
			<div class="container py-lg-2">
				<h2 class="h3 mb-3 pb-3 pb-lg-4 text-center text-lg-start">Seller
					of the month</h2>
				<div class="row">
					<%!String author;%>
					<%
					try {
						Connection conn = DBUtil.getConnection();
						Statement st = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);

						ResultSet rows = st.executeQuery("SELECT * FROM user WHERE b_sold>0");
						rows.last();
						int noOfRows = rows.getRow();
						//System.out.println(noOfRows);

						ResultSet rs3 = st.executeQuery("SELECT * FROM user WHERE id=FLOOR(1+RAND() * " + noOfRows + ")");
						//while(rs3.next()){
						rs3.next();
						author = rs3.getString("fname") + " " + rs3.getString("lname");
						//System.out.println(author);
					%>
					<div class="col-lg-4 text-center text-lg-start pb-3 pt-lg-2">
						<div class="d-inline-block text-start">
							<div class="d-flex align-items-center pb-3">
								<div class="img-thumbnail rounded-circle flex-shrink-0"
									style="width: 6.375rem;">
									<img class="rounded-circle"
										src="img/marketplace/account/avatar.png" alt="userImage">
								</div>
								<div class="ps-3">
									<h3 class="fs-lg mb-0"><%=rs3.getString("fname") + " " + rs3.getString("lname")%></h3>
									<span class="d-block text-muted fs-ms pt-1 pb-2">Member
										since <%=rs3.getString("join_date")%>
									</span><a class="btn btn-primary btn-sm" href="<% out.println((user!=null)? "marketplace-vendor.jsp?name="+author : "account-signin.jsp");%>">View
										Books</a>
								</div>
							</div>
						</div>
					</div>
					<%
					//}
					} catch (Exception e) {
					e.printStackTrace();
					}
					%>

					<div class="col-lg-8">
						<div class="tns-carousel">
							<div class="tns-carousel-inner"
								data-carousel-options="{&quot;items&quot;: 2, &quot;gutter&quot;: 16, &quot;controls&quot;: false, &quot;nav&quot;: true, &quot;responsive&quot;: {&quot;0&quot;:{&quot;items&quot;:1},&quot;500&quot;:{&quot;items&quot;:2},&quot;768&quot;:{&quot;items&quot;:3}}}">
								<%
								try {
									//String query = "SELECT * FROM books WHERE author ";
									String query = "SELECT * FROM books WHERE author ='" + author + "' LIMIT 0,3";
									Connection conn = DBUtil.getConnection();
									PreparedStatement pt = conn.prepareStatement(query);

									//pt.setString(1,author);

									ResultSet rs4 = pt.executeQuery(query);
									while (rs4.next()) {
								%>
								<div>
									<div class="card product-card-alt">
										<div class="product-thumb">
											<div class="product-card-actions">
												<a class="btn btn-light btn-icon btn-shadow fs-base mx-2"
													href=" marketplace-single.jsp?id=<%=rs4.getInt("id")%>"><i class="ci-eye"></i></a>
												<a
													class="btn btn-light btn-icon btn-shadow fs-base mx-2"
													href="CartServlet?id=<%=rs4.getInt("id")%>">
													<i class="ci-cart"></i>
												</a>
											</div>
											<a class="product-thumb-overlay"
												href=" marketplace-single.jsp?id=<%=rs4.getInt("id")%>">
												</a>
												<img
												src="assets/bimages/<%=rs4.getString("image")%>" alt="<%=rs4.getString("image") %>" style="height: 400px; object-fit: cover;">
										</div>
										<div class="card-body">
											<h3 class="product-title fs-sm mb-2">
												<a href=" marketplace-single.jsp?id=<%=rs4.getInt("id")%>"><%=rs4.getString("bname")%></a>
											</h3>
											<div
												class="d-flex flex-wrap justify-content-between align-items-center">
												<div class="fs-sm me-2">
													<i class="ci-download text-muted me-1"></i><%=rs4.getString("bsold")%><span
														class="fs-xs ms-1">Sales</span>
												</div>
												<div class="bg-faded-accent text-accent rounded-1 py-1 px-2">
													&#8377
													<%=rs4.getString("price")%>.<small>00</small>
												</div>
											</div>
										</div>
									</div>
								</div>
								<%
								}
								} catch (Exception e) {
								e.printStackTrace();
								}
								%>


							</div>
						</div>
					</div>
				</div>
			</div>
		</section>

		<!-- Marketplace features-->
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
		<!-- Reviews-->
		<section class="bg-secondary py-5">
			<div class="container py-md-4 pt-3 pb-0 py-sm-3">
				<h2 class="text-center mb-4 mb-md-5">Customer reviews</h2>
				<div class="tns-carousel mb-3">
					<div class="tns-carousel-inner"
						data-carousel-options="{&quot;items&quot;: 2, &quot;controls&quot;: false, &quot;responsive&quot;: {&quot;0&quot;:{&quot;items&quot;:1, &quot;gutter&quot;:20}, &quot;576&quot;:{&quot;items&quot;:2, &quot;gutter&quot;:20},&quot;850&quot;:{&quot;items&quot;:3, &quot;gutter&quot;:20},&quot;1080&quot;:{&quot;items&quot;:4, &quot;gutter&quot;:25}}}">
						<blockquote class="mb-2">
							<div class="card card-body fs-md text-muted border-0 shadow-sm">
								<div class="mb-2">
									<div class="star-rating">
										<i class="star-rating-icon ci-star-filled active"></i><i
											class="star-rating-icon ci-star-filled active"></i><i
											class="star-rating-icon ci-star-filled active"></i><i
											class="star-rating-icon ci-star-filled active"></i><i
											class="star-rating-icon ci-star"></i>
									</div>
								</div>
								"Innovative and user-friendly, BookHub makes finding and buying books a breeze."
							</div>
							
							<footer
								class="d-flex justify-content-center align-items-center pt-4">
								<img class="rounded-circle" src="img/testimonials/03.jpg"
									width="50" alt="Richard Davis">
								<div class="ps-3">
									<h6 class="fs-sm mb-n1">Richard Davis</h6>
									<span class="fs-ms text-muted opacity-75">Feb 14, 2020</span>
								</div>
							</footer>
						</blockquote>
						<blockquote class="mb-2">
							<div class="card card-body fs-md text-muted border-0 shadow-sm">
								<div class="mb-2">
									<div class="star-rating">
										<i class="star-rating-icon ci-star-filled active"></i><i
											class="star-rating-icon ci-star-filled active"></i><i
											class="star-rating-icon ci-star-filled active"></i><i
											class="star-rating-icon ci-star-filled active"></i><i
											class="star-rating-icon ci-star-filled active"></i>
									</div>
								</div>
								"A treasure trove for book lovers, BookHub offers great deals and a vast selection."
							</div>
							<footer
								class="d-flex justify-content-center align-items-center pt-4">
								<img class="rounded-circle" src="img/testimonials/04.jpg"
									width="50" alt="Laura Willson">
								<div class="ps-3">
									<h6 class="fs-sm mb-n1">Laura Willson</h6>
									<span class="fs-ms text-muted opacity-75">Feb 05, 2020</span>
								</div>
							</footer>
						</blockquote>
						<blockquote class="mb-2">
							<div class="card card-body fs-md text-muted border-0 shadow-sm">
								<div class="mb-2">
									<div class="star-rating">
										<i class="star-rating-icon ci-star-filled active"></i><i
											class="star-rating-icon ci-star-filled active"></i><i
											class="star-rating-icon ci-star-filled active"></i><i
											class="star-rating-icon ci-star"></i><i
											class="star-rating-icon ci-star"></i>
									</div>
								</div>
								"BookHub's intuitive design and seamless transactions make it my go-to for ebooks."
							</div>
							<footer
								class="d-flex justify-content-center align-items-center pt-4">
								<img class="rounded-circle" src="img/testimonials/01.jpg"
									width="50" alt="Mary Grant">
								<div class="ps-3">
									<h6 class="fs-sm mb-n1">Mary Alice Grant</h6>
									<span class="fs-ms text-muted opacity-75">Jan 27, 2020</span>
								</div>
							</footer>
						</blockquote>
						<blockquote class="mb-2">
							<div class="card card-body fs-md text-muted border-0 shadow-sm">
								<div class="mb-2">
									<div class="star-rating">
										<i class="star-rating-icon ci-star-filled active"></i><i
											class="star-rating-icon ci-star-filled active"></i><i
											class="star-rating-icon ci-star-filled active"></i><i
											class="star-rating-icon ci-star-filled active"></i><i
											class="star-rating-icon ci-star"></i>
									</div>
								</div>
								"Reliable and efficient, BookHub connects readers to a world of literature."
							</div>
							<footer
								class="d-flex justify-content-center align-items-center pt-4">
								<img class="rounded-circle" src="img/shop/reviews/01.jpg"
									width="50" alt="Rafael Marquez">
								<div class="ps-3">
									<h6 class="fs-sm mb-n1">Rafael Marquez</h6>
									<span class="fs-ms text-muted opacity-75">Dec 19, 2020</span>
								</div>
							</footer>
						</blockquote>
						<blockquote class="mb-2">
							<div class="card card-body fs-md text-muted border-0 shadow-sm">
								<div class="mb-2">
									<div class="star-rating">
										<i class="star-rating-icon ci-star-filled active"></i><i
											class="star-rating-icon ci-star-filled active"></i><i
											class="star-rating-icon ci-star-filled active"></i><i
											class="star-rating-icon ci-star-filled active"></i><i
											class="star-rating-icon ci-star-filled active"></i>
									</div>
								</div>
								"BookHub's marketplace is a game-changer for avid readers and casual browsers alike."
							</div>
							<footer
								class="d-flex justify-content-center align-items-center pt-4">
								<img class="rounded-circle" src="img/testimonials/02.jpg"
									width="50" alt="Adrian Lewis">
								<div class="ps-3">
									<h6 class="fs-sm mb-n1">Adrian Lewis</h6>
									<span class="fs-ms text-muted opacity-75">Dec 13, 2020</span>
								</div>
							</footer>
						</blockquote>
						<blockquote class="mb-2">
							<div class="card card-body fs-md text-muted border-0 shadow-sm">
								<div class="mb-2">
									<div class="star-rating">
										<i class="star-rating-icon ci-star-filled active"></i><i
											class="star-rating-icon ci-star-filled active"></i><i
											class="star-rating-icon ci-star-filled active"></i><i
											class="star-rating-icon ci-star"></i><i
											class="star-rating-icon ci-star"></i>
									</div>
								</div>
								BookHub helped me ace my Software Architecture course. It's not just a project; it's a valuable learning experience.
							</div>
							<footer
								class="d-flex justify-content-center align-items-center pt-4">
								<img class="rounded-circle" src="img/shop/reviews/03.jpg"
									width="50" alt="Daniel Adams">
								<div class="ps-3">
									<h6 class="fs-sm mb-n1">Daniel Adams</h6>
									<span class="fs-ms text-muted opacity-75">Dec 04, 2020</span>
								</div>
							</footer>
						</blockquote>
					</div>
				</div>
			</div>
		</section>
	</main>
	<!-- Footer-->
  	<%@ include file="includes/footer.jsp" %>

	
	<!-- Back To Top Button-->
	<a class="btn-scroll-top" href="#top" data-scroll><span
		class="btn-scroll-top-tooltip text-muted fs-sm me-2">Top</span><i
		class="btn-scroll-top-icon ci-arrow-up"> </i></a>
		
	<!-- Vendor scrits: js libraries and plugins-->
	<%@ include file="includes/vendorScripts.jsp" %>
</body>

</html>