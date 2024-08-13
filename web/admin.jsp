
<%
    if (session == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
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
        main {
            padding: 20px;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        .section {
            margin-bottom: 20px;
        }
        .section h2 {
            border-bottom: 2px solid #333;
            padding-bottom: 10px;
        }
        .logout-btn {
            background: #d9534f;
            color: #fff;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            text-align: center;
        }
        .logout-btn:hover {
            background: #c9302c;
        }
    </style>
</head>
<body>
    <header>
        <h1>Welcome, <%= session.getAttribute("name") %></h1>
        <nav>
            <ul>
                <li><a href="admin.jsp">Dashboard</a></li>
                <li><a href="manageUsers.jsp">Manage Users</a></li>                
                <li><a href="manageCategory.jsp">Manage Category</a></li>
                <li><a href="manageProduct.jsp">Manage Products</a></li>
                <li><a href="adminOrders.jsp">View Orders</a></li>
                <li><a href="logout" class="logout-btn">Logout</a></li>
            </ul>
        </nav>
    </header>

    <main class="container">
        <div class="section">
            <h2>Admin Dashboard</h2>
            <p>Welcome to the admin dashboard. From here, you can manage users, products, and view reports.</p>
        </div>

        <div class="section">
            <h2>Manage Users</h2>
            <p><a href="manageUsers.jsp">View and manage users</a></p>
        </div>
        <div class="section">
            <h2>Manage Category</h2>
            <p><a href="manageCategory.jsp">View and manage Category</a></p>
        </div>

        <div class="section">
            <h2>Manage Products</h2>
            <p><a href="manageProduct.jsp">View and manage products</a></p>
        </div>
        <div class="section">
            <h2>View Orders</h2>
            <p><a href="adminOrders.jsp">View Orders</a></p>
        </div>
    </main>

    <footer>
        <p>&copy; 2024 Your Company. All rights reserved.</p>
    </footer>
</body>
</html>
