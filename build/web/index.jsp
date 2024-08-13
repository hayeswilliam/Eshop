

<%@page import="java.math.BigDecimal"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%@ include file="header.jsp" %>
<%@ page import="eShop.database" %>

<% 
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    List<String> categories = new ArrayList<>();

    try {
        conn = database.getConnection();
        String sql = "SELECT name FROM category";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            categories.add(rs.getString("name"));
            System.out.println("happend");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>


<section class="container section_gap mt-5">
    <div class="category-filter">
    <h3>Filter by Category</h3>
    <ul>
        <li><a href="index.jsp">All Categories</a></li>
        <% for(String category : categories) { %>
            <li><a href="index.jsp?category=<%= category %>"><%= category %></a></li>
        <% } %>
    </ul>
</div>
</section>

<!-- start product Area -->
<section class="">
    <!-- single product slide -->
    <div class="single-product-slider">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-6 text-center">
                    <div class="section-title">
                        <h1>Latest Products</h1>
                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et
                            dolore magna aliqua.</p>
                    </div>
                </div>
            </div>
            <div class="row">
               <%

                    String selectedCategory = request.getParameter("category");
                    String searchKeyword = request.getParameter("search");

                    String sql = "SELECT p.product_id, p.name, p.description, p.price, p.stock_quantity, c.name AS category_name " +
                                 "FROM product p " +
                                 "LEFT JOIN category c ON p.category_id = c.category_id";

                    List<String> conditions = new ArrayList<>();

                    if (selectedCategory != null && !selectedCategory.isEmpty()) {
                        conditions.add("c.name = ?");
                    }

                    if (searchKeyword != null && !searchKeyword.isEmpty()) {
                        conditions.add("p.name LIKE ?");
                    }

                    if (!conditions.isEmpty()) {
                        sql += " WHERE " + String.join(" AND ", conditions);
                    }

                    try {
                        conn = database.getConnection();
                        pstmt = conn.prepareStatement(sql);

                        int index = 1;

                        if (selectedCategory != null && !selectedCategory.isEmpty()) {
                            pstmt.setString(index++, selectedCategory);
                        }

                        if (searchKeyword != null && !searchKeyword.isEmpty()) {
                            pstmt.setString(index++, "%" + searchKeyword + "%");
                        }

                        rs = pstmt.executeQuery();

                        while (rs.next()) {
                            int productId = rs.getInt("product_id");
                            String productName = rs.getString("name");
                            String description = rs.getString("description");
                            BigDecimal price = rs.getBigDecimal("price");
                            int stockQuantity = rs.getInt("stock_quantity");
                            String categoryName = rs.getString("category_name");
                %>
                <!-- single product -->
                <div class="col-lg-3 col-md-6">
                    <div class="single-product">
                        <img class="img-fluid" src="img/diy.jpeg" alt="">
                        <div class="product-details">
                            <h6><%= productName %></h6>
                            <div class="price">
                                <h6>$<%= price %></h6>
                            </div>
                            <div class="prd-bottom">
                                <a href="ViewProduct.jsp?productId=<%= productId %>" class="social-info">
                                    <span class="lnr lnr-move"></span>
                                    <p class="hover-text">view more</p>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- single product -->
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                %>
                
            </div>
        </div>
    </div>
    <!-- single product slide -->
</section>
<!-- end product Area -->

<!-- start features Area -->
<section class="features-area section_gap">
    <div class="container">
        <div class="row features-inner">
            <!-- single features -->
            <div class="col-lg-3 col-md-6 col-sm-6">
                <div class="single-features">
                    <div class="f-icon">
                        <img src="img/f-icon1.png" alt="">
                    </div>
                    <h6>Free Delivery</h6>
                    <p>Free Shipping on all order</p>
                </div>
            </div>
            <!-- single features -->
            <div class="col-lg-3 col-md-6 col-sm-6">
                <div class="single-features">
                    <div class="f-icon">
                        <img src="img/f-icon2.png" alt="">
                    </div>
                    <h6>Return Policy</h6>
                    <p>Free Shipping on all order</p>
                </div>
            </div>
            <!-- single features -->
            <div class="col-lg-3 col-md-6 col-sm-6">
                <div class="single-features">
                    <div class="f-icon">
                        <img src="img/f-icon3.png" alt="">
                    </div>
                    <h6>24/7 Support</h6>
                    <p>Free Shipping on all order</p>
                </div>
            </div>
            <!-- single features -->
            <div class="col-lg-3 col-md-6 col-sm-6">
                <div class="single-features">
                    <div class="f-icon">
                        <img src="img/f-icon4.png" alt="">
                    </div>
                    <h6>Secure Payment</h6>
                    <p>Free Shipping on all order</p>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- end features Area -->

<%@ include file="footer.jsp" %>
