<header class="bg-light shadow-sm navbar-sticky">
			<div class="navbar navbar-expand-lg navbar-light">
				<div class="container">
					<a  class="navbar-brand d-none d-sm-block flex-shrink-0 me-4 order-lg-1"
						href="index.jsp"><img src="img/logonew.png" width="142"
						alt="BookHub"></a> <a
						class="navbar-brand d-sm-none me-2 order-lg-1" href="index.jsp"><img
						src="img/logonew.png" width="74" alt="BookHub"></a>
					<!-- Toolbar-->
					<div class="navbar-toolbar d-flex align-items-center order-lg-3">
						<button class="navbar-toggler" type="button"
							data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
							<span class="navbar-toggler-icon"></span>
						</button>
						<a class="navbar-tool d-none d-lg-flex" href="javascript:void(0)"
							data-bs-toggle="collapse" data-bs-target="#searchBox"
							role="button" aria-expanded="false" aria-controls="searchBox"><span
							class="navbar-tool-tooltip">Search</span>
							<div class="navbar-tool-icon-box">
								<i class="navbar-tool-icon ci-search"></i>
							</div> </a>

						<div class="navbar-tool dropdown ms-2">
							
							

							<%
							if (user != null) {
							%>
<a class="navbar-tool-icon-box border dropdown-toggle"
								href=" dashboard-sales.jsp"><img
								src="assets/uimages/<%= (user.getImage()!=null)? user.getImage() : "avatar-sm.png" %>" width="32" alt="USER"></a>
							<a class="navbar-tool-text ms-n1" href=" dashboard-sales.jsp"><strong><%=user.getFname()%></strong></a>
							<div class="dropdown-menu dropdown-menu-end">
								<div style="min-width: 14rem;">
									<h6 class="dropdown-header">Account</h6>
									<a class="dropdown-item d-flex align-items-center"
										href=" dashboard-profile.jsp"><i
										class="ci-user opacity-60 me-2"></i>Profile</a> <a
										class="dropdown-item d-flex align-items-center"
										href=" dashboard-purchases.jsp"><i
										class="ci-basket opacity-60 me-2"></i>Purchases</a>

									<div class="dropdown-divider"></div>
									<h6 class="dropdown-header">Seller Dashboard</h6>
									<a class="dropdown-item d-flex align-items-center"
										href=" dashboard-sales.jsp"><i
										class="ci-rupee opacity-60 me-2"></i>Sales
										
									</a>
									<a
										class="dropdown-item d-flex align-items-center"
										href=" dashboard-books.jsp"><i
										class="ci-book opacity-60 me-2"></i>Books
					<%!int bookCnt;%>
            	  <%
					try {
						String query = "SELECT COUNT(id) FROM books WHERE author ='"+user.getFname()+" "+user.getLname()+"'";
					
						Connection conn = DBUtil.getConnection();
						Statement st = conn.createStatement();
						
						ResultSet rs1 = st.executeQuery(query);
						if(rs1.next())
						{
							bookCnt = rs1.getInt(1);
						}
					}catch(Exception e){
						e.printStackTrace();
					}
						
					%>
										<span class="fs-xs text-muted ms-auto"><%=bookCnt %></span>
									</a>
									<a
										class="dropdown-item d-flex align-items-center"
										href=" dashboard-add-new-book.jsp"><i
										class="ci-cloud-upload opacity-60 me-2"></i>Add New Book</a><a
										class="dropdown-item d-flex align-items-center"
										href=" dashboard-payouts.jsp"><i
										class="ci-currency-exchange opacity-60 me-2"></i>Payouts</a>
									<div class="dropdown-divider"></div>
									<a class="dropdown-item d-flex align-items-center"
										href="LogoutServlet"><i
										class="ci-sign-out opacity-60 me-2"></i>Sign Out</a>
								</div>
							</div>
						</div>
						<%
						} else {
						%>
						<a class="navbar-tool-icon-box border dropdown-toggle"
								href="account-signin.jsp"><img
								src="img/marketplace/account/avatar-sm.png" width="32" alt=""></a>
						<a class="navbar-tool-text ms-n1" href="account-signin.jsp"><strong>Guest</strong></a>
						<div class="dropdown-menu dropdown-menu-end">
							<div style="min-width: 14rem;">
								<h6 class="dropdown-header">Account</h6>

								<a class="dropdown-item d-flex align-items-center"
									href=" account-signin.jsp"><i
									class="ci-user opacity-60 me-2"></i>Sign in/Sign up</a>
							</div>
						</div>
					</div>
					<%
					}
					%>
					<div class="navbar-tool ms-4">
						<a class="navbar-tool-icon-box bg-secondary dropdown-toggle"
							href="marketplace-cart.jsp"><span class="navbar-tool-label"><%=(cart_list!=null)?cart_list.size():0 %></span><i
							class="navbar-tool-icon ci-cart"></i></a>
					</div>
				</div>
				<div class="collapse navbar-collapse me-auto order-lg-2"
					id="navbarCollapse">
					 <!-- Search-->
					<div class="input-group d-lg-none my-3">
						<i
							class="ci-search position-absolute top-50 start-0 translate-middle-y text-muted fs-base ms-3"></i>
						<input class="form-control rounded-start" type="text"
							placeholder="Search Here">
					</div> 
					
					<!-- Categories dropdown-->
              <ul class="navbar-nav navbar-mega-nav pe-lg-2 me-lg-2">
                <li class="nav-item dropdown"><a class="nav-link dropdown-toggle ps-lg-0" href="#" data-bs-toggle="dropdown"><i class="ci-menu align-middle mt-n1 me-2"></i></a>
                  <ul class="dropdown-menu py-1">
						<%
						try {
							Connection conn = DBUtil.getConnection();
							Statement st = conn.createStatement();
							ResultSet rs = st.executeQuery("SELECT * FROM category");
							while (rs.next()) {
						%>
						<li class="dropdown"><a class="dropdown-item "
							href="marketplace-category.jsp?cname=<%=rs.getString(2)%>"
							><%=rs.getString(2)%></a></li>
						<%
						}

						} catch (Exception e) {
						e.printStackTrace();
						}
						%>
					</ul>
                </li>
              </ul>

					<!-- Primary menu-->
					<ul class="navbar-nav">
						<li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
						<li class="nav-item"><a class="nav-link" href="marketplace-category.jsp">Books</a></li>
						<li class="nav-item"><a class="nav-link" href="about.jsp">About us</a></li>
						<li class="nav-item"><a class="nav-link" href="contacts.jsp">Contact us</a></li>
						<!-- <li class="nav-item"><a class="nav-link" href="#">Components</a></li> -->
					</ul>


				</div>
			</div>
			</div>
			<!-- Search collapse-->
			<div class="search-box collapse" id="searchBox">
				<div class="card pt-2 pb-4 border-0 rounded-0">
					<div class="container">
						<form action="marketplace-category.jsp" method="get">
						<div class="input-group">
							<i class="ci-search position-absolute top-50 start-0 translate-middle-y text-muted fs-base ms-3"></i>
							<input class="form-control rounded-start" type="text" placeholder="Search marketplace" name="bname">
							<button type="submit" class="btn btn-primary btn-shadow">Search Book</button>
						</div>
						</form>
					</div>
				</div>
			</div>
		</header>