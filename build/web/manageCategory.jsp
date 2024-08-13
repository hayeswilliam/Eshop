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
        String newCategoryName = request.getParameter("newCategoryName");
        String deleteCategoryId = request.getParameter("deleteCategoryId");

        if (newCategoryName != null && !newCategoryName.trim().isEmpty()) {
            try {
                conn = database.getConnection();
                String sql = "INSERT INTO category (name) VALUES (?)";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, newCategoryName);
                pstmt.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        } else if (deleteCategoryId != null && !deleteCategoryId.trim().isEmpty()) {
            try {
                conn = database.getConnection();
                String sql = "DELETE FROM category WHERE category_id = ?";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, Integer.parseInt(deleteCategoryId));
                pstmt.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
        response.sendRedirect("manageCategory.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Categories</title>
    <link rel="stylesheet" href="path/to/your/css/style.css">
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
        <h2>Manage Categories</h2>
        
        <form action="manageCategory.jsp" method="post">
            <div class="form-group">
                <label for="newCategoryName">New Category Name:</label>
                <input type="text" id="newCategoryName" name="newCategoryName" required>
                <button type="submit">Add Category</button>
            </div>
        </form>

        <table>
            <thead>
                <tr>
                    <th>Category ID</th>
                    <th>Name</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
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
                <tr>
                    <td><%= categoryId %></td>
                    <td><%= categoryName %></td>
                    <td>
                        <form action="manageCategory.jsp" method="post" style="display:inline;">
                            <input type="hidden" name="deleteCategoryId" value="<%= categoryId %>">
                            <button type="submit">Delete</button>
                        </form>
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
