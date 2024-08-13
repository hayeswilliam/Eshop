<%@page import="java.math.BigDecimal"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ include file="header.jsp" %>

<%
    String productIdParam = request.getParameter("productId");
    int productId = 0;
    if (productIdParam == null || productIdParam.isEmpty()) {
        response.sendRedirect("index.jsp");
        return;
    } else {
        try {
            productId = Integer.parseInt(productIdParam);
        } catch (NumberFormatException e) {
            response.sendRedirect("index.jsp");
            return;
        }
    }

    String productName = "";
    BigDecimal productPrice = null;
    String productDescription = "";
    String productCategory = "";
    String productImage = "";
    String availability = "";
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/eShop", "root", "root1234");
        String sql = "SELECT p.name, p.description, p.price, c.name AS category_name, p.stock_quantity " +
                     "FROM product p " +
                     "LEFT JOIN category c ON p.category_id = c.category_id " +
                     "WHERE p.product_id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, productId);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            productName = rs.getString("name");
            productPrice = rs.getBigDecimal("price");
            productDescription = rs.getString("description");
            productCategory = rs.getString("category_name");
            int stockQuantity = rs.getInt("stock_quantity");
            availability = stockQuantity > 0 ? "In Stock" : "Out of Stock";
        } else {
            response.sendRedirect("index.jsp");
            return;
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("index.jsp");
        return;
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

<!--================Single Product Area =================-->
<div class="product_image_area my-5">
    <div class="container">
        <div class="row s_product_inner">
            <div class="col-lg-6">
                <div class="single-prd-item">
                    <img class="img-fluid" src="img/diy.jpeg">
                </div>
            </div>
            <div class="col-lg-5 offset-lg-1">
                <div class="s_product_text">
                    <h3><%= productName %></h3>
                    <h2>$<%= productPrice %></h2>
                    <ul class="list">
                        <li><a class="active" href="#"><span>Category</span> : <%= productCategory %></a></li>
                        <li><a href="#"><span>Availability</span> : <%= availability %></a></li>
                    </ul>
                    <p><%= productDescription %></p>
                    <form action="AddToCartServlet" method="post">
                        <input type="hidden" name="productId" value="<%= productId %>">
                        <input type="hidden" name="productName" value="<%= productName %>">
                        <input type="hidden" name="productPrice" value="<%= productPrice %>">
                        <div class="product_count">
                            <label for="qty">Quantity:</label>
                            <input type="text" name="quantity" id="sst" maxlength="12" value="1" title="Quantity:" class="input-text qty">
                            <button onclick="var result = document.getElementById('sst'); var sst = result.value; if( !isNaN( sst )) result.value++;return false;"
                             class="increase items-count" type="button"><i class="lnr lnr-chevron-up"></i></button>
                            <button onclick="var result = document.getElementById('sst'); var sst = result.value; if( !isNaN( sst ) && sst > 0 ) result.value--;return false;"
                             class="reduced items-count" type="button"><i class="lnr lnr-chevron-down"></i></button>
                        </div>
                        <div class="card_area d-flex align-items-center">
                            <button type="submit" class="primary-btn">Add to Cart</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<!--================End Single Product Area =================-->

<%@ include file="footer.jsp" %>
