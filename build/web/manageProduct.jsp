<%@page import="java.math.BigDecimal"%>
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

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String stockQuantityStr = request.getParameter("stockQuantity");
        String categoryIdStr = request.getParameter("categoryId");

        if (name != null && !name.trim().isEmpty() && 
            priceStr != null && !priceStr.trim().isEmpty() && 
            stockQuantityStr != null && !stockQuantityStr.trim().isEmpty() && 
            categoryIdStr != null && !categoryIdStr.trim().isEmpty()) {

            try {
                conn = database.getConnection();

                String sql = "INSERT INTO product (name, description, price, stock_quantity, category_id, status) VALUES (?, ?, ?, ?, ?, 'active')";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, name);
                pstmt.setString(2, description);
                pstmt.setBigDecimal(3, new BigDecimal(priceStr));
                pstmt.setInt(4, Integer.parseInt(stockQuantityStr));
                pstmt.setInt(5, Integer.parseInt(categoryIdStr));
                pstmt.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
        response.sendRedirect("manageProduct.jsp");
        return;
    }


        System.out.println("Request Parameters: " + request.getParameterMap());
    String deleteProductId = request.getParameter("deleteProductId");
    System.out.println(deleteProductId);
    if (deleteProductId != null && !deleteProductId.trim().isEmpty()) {
        try {
            
            conn = database.getConnection();
            String sql = "DELETE FROM product WHERE product_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(deleteProductId));
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        response.sendRedirect("manageProduct.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Products</title>
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
        <h2>Manage Products</h2>

        <form action="manageProduct.jsp" method="post">
            <div class="form-group">
                <label for="name">Product Name:</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="description">Description:</label>
                <textarea id="description" name="description" required></textarea>
            </div>
            <div class="form-group">
                <label for="price">Price:</label>
                <input type="number" id="price" name="price" step="0.01" required>
            </div>
            <div class="form-group">
                <label for="stockQuantity">Stock Quantity:</label>
                <input type="number" id="stockQuantity" name="stockQuantity" required>
            </div>
            <div class="form-group">
                <label for="categoryId">Category:</label>
                <select id="categoryId" name="categoryId" required>
                    <% 
                        try {
                            conn = database.getConnection();
                            stmt = conn.createStatement();
                            String sql = "SELECT category_id, name FROM category";
                            rs = stmt.executeQuery(sql);
                            while (rs.next()) {
                                int categoryId = rs.getInt("category_id");
                                String categoryName = rs.getString("name");
                    %>
                    <option value="<%= categoryId %>"><%= categoryName %></option>
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
            <button type="submit">Add Product</button>
        </form>

        <table>
            <thead>
                <tr>
                    <th>Product ID</th>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Price</th>
                    <th>Stock Quantity</th>
                    <th>Category</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        conn = database.getConnection();
                        stmt = conn.createStatement();
                        String sql = "SELECT p.product_id, p.name, p.description, p.price, p.stock_quantity, c.name AS category_name FROM product p LEFT JOIN category c ON p.category_id = c.category_id";
                        rs = stmt.executeQuery(sql);

                        while (rs.next()) {
                            int productId = rs.getInt("product_id");
                            String productName = rs.getString("name");
                            String description = rs.getString("description");
                            BigDecimal price = rs.getBigDecimal("price");
                            int stockQuantity = rs.getInt("stock_quantity");
                            String categoryName = rs.getString("category_name");
                %>
                <tr>
                    <td><%= productId %></td>
                    <td><%= productName %></td>
                    <td><%= description %></td>
                    <td><%= price %></td>
                    <td><%= stockQuantity %></td>
                    <td><%= categoryName %></td>
                    <td>
                        <a href="manageProduct.jsp?deleteProductId=<%= productId %>">Delete</a>
                        <a href="editProduct.jsp?productId=<%= productId %>">Edit</a>
                    </td>
                </tr>
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
            </tbody>
        </table>
    </main>

    <footer>
        <p>&copy; 2024 Your Company. All rights reserved.</p>
    </footer>
</body>
</html>
