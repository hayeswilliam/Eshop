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

    String userId = request.getParameter("userId");
    if (userId == null || userId.trim().isEmpty()) {
        response.sendRedirect("manageUsers.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    String userName = "";

    try {
        conn = database.getConnection();
        String sql = "SELECT name FROM users WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userId);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            userName = rs.getString("name");
        } else {
            response.sendRedirect("manageUsers.jsp");
            return;
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete User</title>
    <link rel="stylesheet" href="path/to/your/css/style.css">
    <style>
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
        <h2>Delete User</h2>
        <form action="DeleteUserAction" method="post">
            <input type="hidden" name="userId" value="<%= userId %>">
            <p>Are you sure you want to delete the user <strong><%= userName %></strong>?</p>
            <button type="submit">Delete User</button>
            <a href="manageUsers.jsp" class="btn">Cancel</a>
        </form>
    </main>

    <footer>
        <p>&copy; 2024 Your Company. All rights reserved.</p>
    </footer>
</body>
</html>
