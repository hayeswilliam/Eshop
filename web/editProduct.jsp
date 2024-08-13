<%@ page import="java.math.BigDecimal" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>
<%@ page import="jakarta.servlet.http.HttpServletResponse" %>
<%@ page import="java.sql.*" %>
<%@page import="eShop.database"%>

<%
    if (session == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("index.jsp");
        return;
    }

    String productId = request.getParameter("productId");
    
    if (productId != null && !productId.trim().isEmpty() ) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = database.getConnection();
            String sql = "SELECT * FROM product WHERE product_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(productId));
            rs = pstmt.executeQuery();

            if (rs.next()) {
                request.setAttribute("prodId", rs.getInt("product_id"));
                request.setAttribute("name", rs.getString("name"));
                request.setAttribute("description", rs.getString("description"));
                request.setAttribute("price", rs.getBigDecimal("price"));
                request.setAttribute("stockQuantity", rs.getInt("stock_quantity"));
                request.setAttribute("categoryId", rs.getInt("category_id"));
            } else {
                response.sendRedirect("manageProduct.jsp");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Product</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        header {
            background-color: #333;
            color: #fff;
            padding: 10px 0;
            text-align: center;
        }
        header h1 {
            margin: 0;
        }
        nav ul {
            list-style: none;
            padding: 0;
        }
        nav ul li {
            display: inline;
            margin: 0 10px;
        }
        nav ul li a {
            color: #fff;
            text-decoration: none;
        }
        .container {
            width: 80%;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        button {
            padding: 10px 15px;
            background-color: #d9534f;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #c9302c;
        }
        footer {
            text-align: center;
            padding: 10px;
            background-color: #333;
            color: #fff;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f4f4f4;
        }
        .actions a {
            margin-right: 10px;
            text-decoration: none;
            color: #007bff;
        }
        .actions a:hover {
            text-decoration: underline;
        }

    </style>
</head>
<body>
    <header>
        <h1>Welcome, <%= session.getAttribute("name") %></h1>
        <nav>
            <ul>
                <li><a href="admin.jsp">Dashboard</a></li>
                <li><a href="index.jsp" class="logout-btn">Logout</a></li>
            </ul>
        </nav>
    </header>

    <main class="container">
        <h2>Edit Product</h2>

        <% 
            if (request.getAttribute("prodId") != null) {
                int prodId = (Integer) request.getAttribute("prodId");
                String name = (String) request.getAttribute("name");
                String description = (String) request.getAttribute("description");
                BigDecimal price = (BigDecimal) request.getAttribute("price");
                int stockQuantity = (Integer) request.getAttribute("stockQuantity");
                int categoryId = (Integer) request.getAttribute("categoryId");
        %>
        <form action="UpdateProductServlet" method="post">
            <input type="hidden" name="productId" value="<%= prodId %>">
            <input type="hidden" name="action" value="update">
            <div class="form-group">
                <label for="name">Product Name:</label>
                <input type="text" id="name" name="name" value="<%= name %>" required>
            </div>
            <div class="form-group">
                <label for="description">Description:</label>
                <textarea id="description" name="description" required><%= description %></textarea>
            </div>
            <div class="form-group">
                <label for="price">Price:</label>
                <input type="number" id="price" name="price" step="0.01" value="<%= price %>" required>
            </div>
            <div class="form-group">
                <label for="stockQuantity">Stock Quantity:</label>
                <input type="number" id="stockQuantity" name="stockQuantity" value="<%= stockQuantity %>" required>
            </div>
            <div class="form-group">
                <label for="categoryId">Category:</label>
                <select id="categoryId" name="categoryId" required>
                    <% 
                        Connection conn = null;
                        Statement stmt = null;
                        ResultSet rs = null;
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/eShop", "root", "root1234");
                            stmt = conn.createStatement();
                            String sql = "SELECT category_id, name FROM category";
                            rs = stmt.executeQuery(sql);
                            while (rs.next()) {
                                int categoryIdOption = rs.getInt("category_id");
                                String categoryName = rs.getString("name");
                                String selected = (categoryId == categoryIdOption) ? "selected" : "";
                    %>
                    <option value="<%= categoryIdOption %>" <%= selected %>><%= categoryName %></option>
                    <% 
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }
                    %>
                </select>
            </div>
            <button type="submit">Update Product</button>
        </form>
        <% 
            } else {
                out.println("Product not found.");
            }
        %>
    </main>

    <footer>
        <p>&copy; 2024 Your Company. All rights reserved.</p>
    </footer>
</body>
</html>
