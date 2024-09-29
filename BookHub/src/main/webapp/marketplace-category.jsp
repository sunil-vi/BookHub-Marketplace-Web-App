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
    <title>Books</title>
    <%@ include file="includes/head.jsp"%>
  </head>
  <!-- Body-->
  <body class="handheld-toolbar-enabled">

    <main class="page-wrapper">
      <!-- Navbar Marketplace-->
     <%@ include file="includes/header.jsp" %>
      
      <!-- arrow namess-->
      <div class="bg-accent pt-4 pb-5">
        <div class="container pt-2 pb-3 pt-lg-3 pb-lg-4">
          <div class="d-lg-flex justify-content-between pb-3">
            <div class="order-lg-2 mb-3 mb-lg-0 pt-lg-2">
              <nav aria-label="breadcrumb">
                <ol class="breadcrumb breadcrumb-light flex-lg-nowrap justify-content-center justify-content-lg-start">
                  <li class="breadcrumb-item"><a class="text-nowrap" href="index.jsp"><i class="ci-home"></i>Home</a></li>
                  <li class="breadcrumb-item text-nowrap"><a href="#">Market</a>
                  </li>
                  <li class="breadcrumb-item text-nowrap active" aria-current="page">Inside category</li>
                </ol>
              </nav>
            </div>
            <div class="order-lg-1 pe-lg-4 text-center text-lg-start">
              <h1 class="h3 text-light mb-0">BookHub category</h1>
            </div>
          </div>
        </div>
      </div>
      <div class="container pb-5 mb-2 mb-md-4">
        
        <!-- Books grid-->
        <div class="row pt-3 mx-n2">
        <%
        String category = request.getParameter("cname");
    	String bname = request.getParameter("bname");
        if(category!=null){
        	String query = "SELECT * FROM books WHERE cat_name = '"+category+"'ORDER BY 1 DESC LIMIT 0,12";
				try {
					Connection conn = DBUtil.getConnection();
					Statement st = conn.createStatement();
					ResultSet rs = st.executeQuery(query);
		
					while (rs.next()) {
				%>
          <!-- Book-->
          <div class="col-lg-3 col-md-4 col-sm-6 px-2 mb-grid-gutter">
            <div class="card product-card-alt">
              <div class="product-thumb">
                
                <div class="product-card-actions"><a class="btn btn-light btn-icon btn-shadow fs-base mx-2" href="marketplace-single.jsp?id=<%=rs.getString("id")%>"><i class="ci-eye"></i></a>
                  <a class="btn btn-light btn-icon btn-shadow fs-base mx-2" href="CartServlet?id=<%=rs.getInt("id")%>"><i class="ci-cart"></i></a>
                </div><a class="product-thumb-overlay" href="marketplace-single.jsp?id=<%=rs.getString("id")%>"></a><img src="assets/bimages/<%=rs.getString("image")%>" alt="<%=rs.getString("image")%>" style="height: 500px; object-fit: cover;">
              </div>
              <div class="card-body">
                <div class="d-flex flex-wrap justify-content-between align-items-start pb-2">
                  <div class="text-muted fs-xs me-1">by <a class="product-meta fw-medium" href="#"><%=rs.getString("author")%>. </a>in <a class="product-meta fw-medium" href="#"><%=rs.getString("cat_name")%></a></div>
                  <div class="star-rating"><i class="star-rating-icon ci-star-filled active"></i><i class="star-rating-icon ci-star-filled active"></i><i class="star-rating-icon ci-star-filled active"></i><i class="star-rating-icon ci-star-filled active"></i><i class="star-rating-icon ci-star-filled active"></i>
                  </div>
                </div>
                <h3 class="product-title fs-sm mb-2"><a href="marketplace-single.jsp?id=<%=rs.getString("id")%>"><%=rs.getString("bname")%></a></h3>
                <div class="d-flex flex-wrap justify-content-between align-items-center">
                  <div class="fs-sm me-2"><i class="ci-download text-muted me-1"></i><%=rs.getString("bsold")%><span class="fs-xs ms-1">Sales</span></div>
                  <div class="bg-faded-accent text-accent rounded-1 py-1 px-2">&#8377 <%=rs.getString("price")%>.<small>00</small></div>
                </div>
              </div>
            </div>
          </div>
          <%
				}
				} catch (Exception e) {
				e.printStackTrace();
				}
			}else if(bname!=null){ 
				String query = "SELECT * FROM books WHERE bname OR tags LIKE '%"+bname+"%' ORDER BY 1 DESC LIMIT 0,12";
				try {
					Connection conn = DBUtil.getConnection();
					Statement st = conn.createStatement();
					ResultSet rs = st.executeQuery(query);
					while (rs.next()) {
		%>
          
          <!-- Book-->
          <div class="col-lg-3 col-md-4 col-sm-6 px-2 mb-grid-gutter">
            <div class="card product-card-alt">
              <div class="product-thumb">
                
                <div class="product-card-actions"><a class="btn btn-light btn-icon btn-shadow fs-base mx-2" href="marketplace-single.jsp?id=<%=rs.getString("id")%>"><i class="ci-eye"></i></a>
                  <a class="btn btn-light btn-icon btn-shadow fs-base mx-2" href="CartServlet?id=<%=rs.getInt("id")%>"><i class="ci-cart"></i></a>
                </div><a class="product-thumb-overlay" href="marketplace-single.jsp?id=<%=rs.getString("id")%>"></a><img src="assets/bimages/<%=rs.getString("image")%>" alt="<%=rs.getString("image")%>" style="height: 500px; object-fit: cover;">
              </div>
              <div class="card-body">
                <div class="d-flex flex-wrap justify-content-between align-items-start pb-2">
                  <div class="text-muted fs-xs me-1">by <a class="product-meta fw-medium" href="#"><%=rs.getString("author")%>. </a>in <a class="product-meta fw-medium" href="#"><%=rs.getString("cat_name")%></a></div>
                  <div class="star-rating"><i class="star-rating-icon ci-star-filled active"></i><i class="star-rating-icon ci-star-filled active"></i><i class="star-rating-icon ci-star-filled active"></i><i class="star-rating-icon ci-star-filled active"></i><i class="star-rating-icon ci-star-filled active"></i>
                  </div>
                </div>
                <h3 class="product-title fs-sm mb-2"><a href="marketplace-single.jsp?id=<%=rs.getString("id")%>"><%=rs.getString("bname")%></a></h3>
                <div class="d-flex flex-wrap justify-content-between align-items-center">
                  <div class="fs-sm me-2"><i class="ci-download text-muted me-1"></i><%=rs.getString("bsold")%><span class="fs-xs ms-1">Sales</span></div>
                  <div class="bg-faded-accent text-accent rounded-1 py-1 px-2">&#8377 <%=rs.getString("price")%>.<small>00</small></div>
                </div>
              </div>
            </div>
          </div>
			<%
				}
				} catch (Exception e) {
				e.printStackTrace();
				}
			}else{ 
				
				try {
					Connection conn = DBUtil.getConnection();
					Statement st = conn.createStatement();
					ResultSet rs = st.executeQuery("SELECT * FROM books ORDER BY 1 DESC LIMIT 0,12"); 
					while (rs.next()) {
		%>
          
          <!-- Book-->
          <div class="col-lg-3 col-md-4 col-sm-6 px-2 mb-grid-gutter">
            <div class="card product-card-alt">
              <div class="product-thumb">
                
                <div class="product-card-actions"><a class="btn btn-light btn-icon btn-shadow fs-base mx-2" href="marketplace-single.jsp?id=<%=rs.getString("id")%>"><i class="ci-eye"></i></a>
                  <a class="btn btn-light btn-icon btn-shadow fs-base mx-2" href="CartServlet?id=<%=rs.getInt("id")%>"><i class="ci-cart"></i></a>
                </div><a class="product-thumb-overlay" href="marketplace-single.jsp?id=<%=rs.getString("id")%>"></a><img src="assets/bimages/<%=rs.getString("image")%>" alt="<%=rs.getString("image")%>" style="height: 500px; object-fit: cover;">
              </div>
              <div class="card-body">
                <div class="d-flex flex-wrap justify-content-between align-items-start pb-2">
                  <div class="text-muted fs-xs me-1">by <a class="product-meta fw-medium" href="#"><%=rs.getString("author")%>. </a>in <a class="product-meta fw-medium" href="#"><%=rs.getString("cat_name")%></a></div>
                  <div class="star-rating"><i class="star-rating-icon ci-star-filled active"></i><i class="star-rating-icon ci-star-filled active"></i><i class="star-rating-icon ci-star-filled active"></i><i class="star-rating-icon ci-star-filled active"></i><i class="star-rating-icon ci-star-filled active"></i>
                  </div>
                </div>
                <h3 class="product-title fs-sm mb-2"><a href="marketplace-single.jsp?id=<%=rs.getString("id")%>"><%=rs.getString("bname")%></a></h3>
                <div class="d-flex flex-wrap justify-content-between align-items-center">
                  <div class="fs-sm me-2"><i class="ci-download text-muted me-1"></i><%=rs.getString("bsold")%><span class="fs-xs ms-1">Sales</span></div>
                  <div class="bg-faded-accent text-accent rounded-1 py-1 px-2">&#8377 <%=rs.getString("price")%>.<small>00</small></div>
                </div>
              </div>
            </div>
          </div>
        <%
			}
			} catch (Exception e) {
			e.printStackTrace();
			}
			} %>
        </div>
        
        <hr class="my-3">
        
        
      </div>
    </main>

    <!-- Footer-->
    <%@ include file="includes/footer.jsp" %>
    <!-- Toolbar for handheld devices (Marketplace)-->
    <div class="handheld-toolbar">
      <div class="d-table table-layout-fixed w-100"><a class="d-table-cell handheld-toolbar-item" href="dashboard-favorites.jsp"><span class="handheld-toolbar-icon"><i class="ci-heart"></i></span><span class="handheld-toolbar-label">Favorites</span></a><a class="d-table-cell handheld-toolbar-item" href="javascript:void(0)" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" onclick="window.scrollTo(0, 0)"><span class="handheld-toolbar-icon"><i class="ci-menu"></i></span><span class="handheld-toolbar-label">Menu</span></a><a class="d-table-cell handheld-toolbar-item" href="marketplace-cart.jsp"><span class="handheld-toolbar-icon"><i class="ci-cart"></i><span class="badge bg-primary rounded-pill ms-1">3</span></span><span class="handheld-toolbar-label">$56.00</span></a></div>
    </div>
    <!-- Back To Top Button--><a class="btn-scroll-top" href="#top" data-scroll><span class="btn-scroll-top-tooltip text-muted fs-sm me-2">Top</span><i class="btn-scroll-top-icon ci-arrow-up">   </i></a>

    <!-- Vendor scrits: js libraries and plugins-->
    <%@ include file="includes/vendorScripts.jsp" %>
  </body>


</html>