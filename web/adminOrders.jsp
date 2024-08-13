<%@page import="java.math.BigDecimal"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="eShop.database" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin View Orders</title>
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

    <div class="container">
        <h2>All Orders</h2>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>User Name</th>
                    <th>Total Amount</th>
                    <th>Order Date</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try {
                        conn = database.getConnection();

                        String sql = "SELECT o.order_id, u.name, o.total_amount, o.order_date " +
                                     "FROM orders o " +
                                     "JOIN users u ON o.user_id = u.id";
                        pstmt = conn.prepareStatement(sql);
                        rs = pstmt.executeQuery();

                        while (rs.next()) {
                            int orderId = rs.getInt("order_id");
                            String userName = rs.getString("name");
                            BigDecimal totalAmount = rs.getBigDecimal("total_amount");
                            Timestamp orderDate = rs.getTimestamp("order_date");
                %>
                <tr>
                    <td><%= orderId %></td>
                    <td><%= userName %></td>
                    <td><%= totalAmount %></td>
                    <td><%= orderDate %></td>
                    <td><a href="adminOrderDetails.jsp?orderId=<%= orderId %>" class="actions">View Details</a></td>
                </tr>
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
            </tbody>
        </table>
    </div>

    <footer>
        <p>&copy; 2024 Your Company. All rights reserved.</p>
    </footer>
</body>
</html>
