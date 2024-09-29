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
  <title>Vendor Page</title>
  <%@ include file="includes/head.jsp" %>
  
  </head>
  <!-- Body-->
  <body class="handheld-toolbar-enabled">
    <%String author=(String) request.getParameter("name"); %>

    <main class="page-wrapper">
      <!-- Navbar Marketplace-->
      <%@ include file="includes/header.jsp" %>

      <!-- Header-->
        <%
					try {
						String[] words = author.split(" ");
						String query31 = "SELECT * FROM user WHERE fname LIKE '%"+words[0]+"%'";
					
						Connection conn = DBUtil.getConnection();
						Statement st = conn.createStatement();
						
						ResultSet rs31 = st.executeQuery(query31);
						rs31.next();
						
						%>
					
      
      
      <div class="page-title-overlap bg-accent pt-4">
        <div class="container d-flex flex-wrap flex-sm-nowrap justify-content-center justify-content-sm-between align-items-center pt-2">
          <div class="d-flex align-items-center pb-3">
            <div class="img-thumbnail rounded-circle position-relative flex-shrink-0" style="width: 6.375rem;"><img class="rounded-circle" src="assets/uimages/<%=rs31.getString("image")%>" alt="BookHub"></div>
            <div class="ps-3">
              <h3 class="text-light fs-lg mb-0"><%=author %></h3><span class="d-block text-light fs-ms opacity-60 py-1">Member since  <%=rs31.getString("join_date")%></span>
            </div>
          </div>
          <%}catch(Exception e){
						e.printStackTrace();
					}
						
					%>
          <div class="d-flex">
            <div class="text-sm-end me-5">
              <div class="text-light fs-base">Total sales</div>
              
          
            	  <%!int sales;%>
            	  <%
					try {
						String query = "SELECT SUM(bsold) FROM books WHERE author ='"+author+"'";
					
						Connection conn = DBUtil.getConnection();
						Statement st = conn.createStatement();
						
						ResultSet rs1 = st.executeQuery(query);
						if(rs1.next())
						{
							sales = rs1.getInt(1);
						}
					}catch(Exception e){
						e.printStackTrace();
					}
						
					%>
            	
              <h3 class="text-light"><%=sales %></h3>
            </div>
            <div class="text-sm-end">
              <div class="text-light fs-base">Seller rating</div>
              <div class="star-rating"><i class="star-rating-icon ci-star-filled active"></i><i class="star-rating-icon ci-star-filled active"></i><i class="star-rating-icon ci-star-filled active"></i><i class="star-rating-icon ci-star-filled active"></i><i class="star-rating-icon ci-star"></i>
              </div>
              <div class="text-light opacity-60 fs-xs">Based on <%=new Random().nextInt(100) %> reviews</div>
            </div>
          </div>
        </div>
      </div>
      
      <div class="container mb-5 pb-3">
        <div class="bg-light shadow-lg rounded-3 overflow-hidden">
          <div class="row">
            <!-- Sidebar-->
            <aside class="col-lg-4 pe-xl-5">
              <div class="bg-white h-100 border-end p-4">
                <div class="p-2">
                  <h6>About</h6>
                  <p class="fs-ms text-muted">An esteemed pillar of our literary community,	<%=author %> crafts stories that reflect our shared experiences and aspirations. Their work not only entertains but also inspires dialogue and connection among readers.</p>
                  <hr class="my-4">
                  <h6>Contacts</h6>
                  <ul class="list-unstyled fs-sm">
                    <li><a class="nav-link-style d-flex align-items-center" href="#"><i class="ci-mail opacity-60 me-2"></i>contact@bookhub.com</a></li>
                    <li><a class="nav-link-style d-flex align-items-center" href="#"><i class="ci-globe opacity-60 me-2"></i>www.bookhub.com</a></li>
                  </ul><a class="btn-social bs-facebook bs-outline bs-sm me-2 mb-2" href="#"><i class="ci-facebook"></i></a><a class="btn-social bs-twitter bs-outline bs-sm me-2 mb-2" href="#"><i class="ci-twitter"></i></a></i></a>
                  <hr class="my-4">
                  
                </div>
              </div>
            </aside>
            <!-- Content-->
            
            <%!int aRows;%>
            <%
            
            try {
						Connection conn = DBUtil.getConnection();
						Statement st = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);

						ResultSet rows = st.executeQuery("SELECT * FROM books WHERE author ='" + author+"'");
						rows.last();
						aRows = rows.getRow();
						}catch (Exception e) {
					e.printStackTrace();
					}
					%>
            <section class="col-lg-8 pt-lg-4 pb-md-4">
              <div class="pt-2 px-4 ps-lg-0 pe-xl-5">
                <h2 class="h3 pt-2 pb-4 mb-4 text-center text-sm-start border-bottom">Books<span class="badge bg-faded-accent fs-sm text-body align-middle ms-2"><%=aRows %></span></h2>
                <div class="row pt-2">
                
                  <!-- Book-->
                  <%
								try {
									
								
									//String query = "SELECT * FROM books WHERE author ";
									String query15 = "SELECT * FROM books WHERE author ='" + author+"'";
									Connection conn = DBUtil.getConnection();
									PreparedStatement pt = conn.prepareStatement(query15);

									//pt.setString(1,author);

									ResultSet rs43 = pt.executeQuery(query15);
									
									while (rs43.next()) {
								%>
                  <div class="col-sm-6 mb-grid-gutter">
                    <div class="card product-card-alt">
                      <div class="product-thumb">
                        
                        <div class="product-card-actions"><a class="btn btn-light btn-icon btn-shadow fs-base mx-2" href="marketplace-single.jsp?id=<%=rs43.getInt("id")%>"><i class="ci-eye"></i></a>
                          <a class="btn btn-light btn-icon btn-shadow fs-base mx-2" href="CartServlet?id=<%=rs43.getInt("id")%>"><i class="ci-cart"></i></a>
                        </div><a class="product-thumb-overlay" href="marketplace-single.jsp?id=<%=rs43.getInt("id")%>"></a><img src="assets/bimages/<%=rs43.getString("image")%>" alt="<%=rs43.getString("image") %>" style=" height: 500px; object-fit: cover;">
                      </div>
                      <div class="card-body">
                        <div class="d-flex flex-wrap justify-content-between align-items-start pb-2">
                          <div class="text-muted fs-xs me-1">by <a class="product-meta fw-medium" href="#"><%=rs43.getString("author") %></a>in <a class="product-meta fw-medium" href="#"><%=rs43.getString("cat_name") %></a></div>
                          <div class="star-rating"><i class="star-rating-icon ci-star-filled active"></i><i class="star-rating-icon ci-star-filled active"></i><i class="star-rating-icon ci-star-filled active"></i><i class="star-rating-icon ci-star-filled active"></i><i class="star-rating-icon ci-star-filled active"></i>
                          </div>
                        </div>
                        <h3 class="product-title fs-sm mb-2"><a href="marketplace-single.jsp?id=<%=rs43.getInt("id")%>"><%=rs43.getString("bname") %></a></h3>
                        <div class="d-flex flex-wrap justify-content-between align-items-center">
                          <div class="fs-sm me-2"><i class="ci-download text-muted me-1"></i><%=rs43.getInt("bsold") %><span class="fs-xs ms-1">Sales</span></div>
                          <div class="bg-faded-accent text-accent rounded-1 py-1 px-2">&#8377 <%=rs43.getInt("price") %>.<small>00</small></div>
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