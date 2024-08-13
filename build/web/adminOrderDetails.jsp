<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="eShop.database" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin View Order Details</title>
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
        <h2>Order Details</h2>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Product ID</th>
                    <th>Product Name</th>
                    <th>Quantity</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;
                    int orderId = Integer.parseInt(request.getParameter("orderId"));
                    System.out.println(orderId);

                    try {
                        conn = database.getConnection();

                        String sql = "SELECT p.product_id, p.name, op.quantity " +
                                     "FROM ordered_products op " +
                                     "JOIN product p ON op.product_id = p.product_id " +
                                     "WHERE op.order_id = ?";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setInt(1, orderId);
                        rs = pstmt.executeQuery();

                        while (rs.next()) {
                            int productId = rs.getInt("product_id");
                            String productName = rs.getString("name");
                            int quantity = rs.getInt("quantity");
                %>
                <tr>
                    <td><%= productId %></td>
                    <td><%= productName %></td>
                    <td><%= quantity %></td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        // Clean up resources
                        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                %>
            </tbody>
        </table>
        <a href="adminOrders.jsp" class="btn btn-secondary">Back to Orders</a>
    </div>

    <footer>
        <p>&copy; 2024 Your Company. All rights reserved.</p>
    </footer>
</body>
</html>
