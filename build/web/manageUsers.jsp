<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>
<%@ page import="jakarta.servlet.http.HttpServletResponse" %>
<%@ page import="jakarta.servlet.ServletException" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@page import="eShop.database"%>

<%
    if (session == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("index.jsp");
        return;
    }

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    List<String[]> users = new ArrayList<>();

    try {
        conn = database.getConnection();
        stmt = conn.createStatement();
        String sql = "SELECT id, name, email, role, status FROM users";
        rs = stmt.executeQuery(sql);

        while (rs.next()) {
            String[] user = {
                rs.getString("id"),
                rs.getString("name"),
                rs.getString("email"),
                rs.getString("role"),
                rs.getString("status")

            };
            users.add(user);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users</title>
    <link rel="stylesheet" href="path/to/your/css/style.css">
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        header {
            background: #333;
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
            margin: 0 15px;
        }
        nav ul li a {
            color: #fff;
            text-decoration: none;
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
        <h2>Manage Users</h2>
        <table>
            <thead>
                <tr>
                    <th>User ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>status</th>
                    <th>Actions</th>
                    
                </tr>
            </thead>
            <tbody>
                <% for (String[] user : users) { %>
                <tr>
                    <td><%= user[0] %></td>
                    <td><%= user[1] %></td>
                    <td><%= user[2] %></td>
                    <td><%= user[3] %></td>
                    <td><%= user[4] %></td>
                    <td class="actions">
                        <a href="editUser.jsp?userId=<%= user[0] %>">Edit</a>
                        <a href="deleteUser.jsp?userId=<%= user[0] %>">Delete</a>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </main>

    <footer>
        <p>&copy; 2024 Your Company. All rights reserved.</p>
    </footer>
</body>
</html>
