<footer class="footer bg-dark pt-5">
		<div class="container pt-2 pb-3">
			<div class="row">
				<div class="col-md-6 text-center text-md-start mb-4">
					<div class="text-nowrap mb-3">
						<a class="d-inline-block align-middle mt-n2 me-2" href="#"><text
							class="fs-4"  width="117"
							>BookHub</text></a><span
							class="d-inline-block align-middle h5 fw-light text-white mb-0">Marketplace</span>
					</div>
			<%int bookCount=0,mem=0,auth=0; %>		
					
<%
								try {
									//String query = "SELECT * FROM books WHERE author ";
									String query9 = "SELECT COUNT(id) FROM books";
									Connection conn = DBUtil.getConnection();
									PreparedStatement pt1 = conn.prepareStatement(query9);
									ResultSet res4 = pt1.executeQuery(query9);
									res4.next();
									bookCount = res4.getInt(1);

									String query8 = "SELECT COUNT(id) FROM user WHERE b_sold>0";
								
									PreparedStatement pt2 = conn.prepareStatement(query8);
									ResultSet res5 = pt2.executeQuery(query8);
									res5.next();
									auth = res5.getInt(1);
									
									String query21 = "SELECT COUNT(id) FROM user";
								
									PreparedStatement pt3 = conn.prepareStatement(query21);
									ResultSet res6 = pt3.executeQuery(query21);
									res6.next();
									mem = res6.getInt(1);
									
									}catch(Exception e)
{
									e.printStackTrace();
}
								%>
									
									
																
					<p class="fs-sm text-white opacity-70 pb-1">Well-researched books
						created by our global community.</p>
					<h6 class="d-inline-block pe-3 me-3 border-end border-light">
						<span class="text-primary"><%=bookCount %> </span><span
							class="fw-normal text-white"> Books</span>
					</h6>
					<h6 class="d-inline-block pe-3 me-3 border-end border-light">
						<span class="text-primary"><%=mem %></span><span
							class="fw-normal text-white"> Members</span>
					</h6>
					<h6 class="d-inline-block me-3">
						<span class="text-primary"><%=auth %></span><span
							class="fw-normal text-white"> Authors</span>
					</h6>
					

					<div class="widget mt-4 text-md-nowrap text-center text-md-start">
						<a class="btn-social bs-light bs-twitter me-2 mb-2" href="#"><i
							class="ci-twitter"></i></a><a
							class="btn-social bs-light bs-facebook me-2 mb-2" href="#"><i
							class="ci-facebook"></i></a><a
							class="btn-social bs-light bs-pinterest me-2 mb-2" href="#"><i
							class="ci-pinterest"></i></a>
					</div>
				</div>
				<!-- Mobile dropdown menu (visible on screens below md)-->
				<div class="col-12 d-md-none text-center mb-4 pb-2">
					<div class="btn-group dropdown d-block mx-auto mb-3">
						<button class="btn btn-outline-light border-light dropdown-toggle"
							type="button" data-bs-toggle="dropdown">Categories</button>
						<ul class="dropdown-menu my-1">
							<li><a class="dropdown-item" href="marketplace-category.jsp?cname=Novel">Novel</a></li>
							<li><a class="dropdown-item" href="marketplace-category.jsp?cname=Fiction">Fiction</a></li>
							<li><a class="dropdown-item" href="marketplace-category.jsp?cname=Technology">Technology</a></li>
							<li><a class="dropdown-item" href="marketplace-category.jsp?cname=Health">Health</a></li>
							<!-- <li><a class="dropdown-item" href="#">Fonts</a></li> -->
							<!-- <li><a class="dropdown-item" href="#">Add-Ons</a></li> -->
						</ul>
					</div>
					<div class="btn-group dropdown d-block mx-auto">
						<button class="btn btn-outline-light border-light dropdown-toggle"
							type="button" data-bs-toggle="dropdown">Marketplace</button>
						<ul class="dropdown-menu my-1">
							<li><a class="dropdown-item" href="index.jsp">Home</a></li>
							<li><a class="dropdown-item" href="dashboard-books.jsp">Books</a></li>
							<li><a class="dropdown-item" href="contacts.jsp">Contact us</a></li>
							<li><a class="dropdown-item" href="about.jsp">Aboutus</a></li>
							
						</ul>
					</div>
				</div>
				<!-- Desktop menu (visible on screens above md)-->
				<div
					class="col-md-3 d-none d-md-block text-center text-md-start mb-4">
					<div class="widget widget-links widget-light pb-2">
						<h3 class="widget-title text-light">Categories</h3>
						<ul class="widget-list">
							<li class="widget-list-item"><a class="widget-list-link"
								href="marketplace-category.jsp?cname=Novel">Novel</a></li>
							<li class="widget-list-item"><a class="widget-list-link"
								href="marketplace-category.jsp?cname=Fiction">Fiction</a></li>
							<li class="widget-list-item"><a class="widget-list-link"
								href="marketplace-category.jsp?cname=Technology">Techonology</a></li>
							<li class="widget-list-item"><a class="widget-list-link"
								href="marketplace-category.jsp?cname=Health">Health</a></li>
						
						</ul>
					</div>
				</div>
				<div
					class="col-md-3 d-none d-md-block text-center text-md-start mb-4">
					<div class="widget widget-links widget-light pb-2">
						<h3 class="widget-title text-light">Marketplace</h3>
						<ul class="widget-list">
							<li class="widget-list-item"><a class="widget-list-link"
								href="index.jsp">Home</a></li>
							<li class="widget-list-item"><a class="widget-list-link"
								href="dashboard-books.jsp">Books</a></li>
							<li class="widget-list-item"><a class="widget-list-link"
								href="about.jsp">About us</a></li>
							<li class="widget-list-item"><a class="widget-list-link"
								href="contacts.jsp">Contact us</a></li>
							
						</ul>
					</div>
				</div>
			</div>
		</div>
		<!-- Second row-->
		<div class="pt-5 bg-darker">
			<div class="container">
				<div class="widget w-100 mb-4 pb-3 text-center mx-auto"
					style="max-width: 28rem;">
					<h3 class="widget-title text-light pb-1">Subscribe to
						newsletter</h3>
					<form class="subscription-form validate"
						action="NewsletterServlet"
						method="get" name="mc-embedded-subscribe-form" 
						novalidate>
						<div class="input-group flex-nowrap">
							<i
								class="ci-mail position-absolute top-50 translate-middle-y text-muted fs-base ms-3"></i>
							<input class="form-control rounded-start" type="email"
								name="recipient" placeholder="Your email" required>
							<button class="btn btn-primary" type="submit">Subscribe*</button>
						</div>
						<!-- real people should not fill this in and expect good things - do not remove this or risk form bot signups-->
						<div style="position: absolute; left: -5000px;" aria-hidden="true">
							<input class="subscription-form-antispam" type="email"
								name="recipient" tabindex="-1">
						</div>
						<div class="form-text text-light opacity-50">*Receive early
							discount offers, updates and new Books info.</div>
						<div class="subscription-status"></div>
					</form>
				</div>
				<hr class="hr-light mb-3">
				<div class="d-md-flex justify-content-between pt-4">
					<div
						class="pb-4 fs-xs text-light opacity-50 text-center text-md-start">
						© All rights reserved. Made by <a class="text-light"
							href="index.jsp" target="_blank" rel="">BookHub</a>
					</div>
					<div class="widget widget-links widget-light pb-4">
						<ul
							class="widget-list d-flex flex-wrap justify-content-center justify-content-md-start">
							<a class="widget-list-link fs-ms" href="#">Terms &amp;
									Conditions</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</footer>
