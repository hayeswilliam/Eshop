<%@page import="java.sql.*, java.util.*" %>
<%@page import="eShop.database" %>
<%@page contentType="text/html;charset=UTF-8" %>

<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String query = request.getParameter("query");

    if (query != null && !query.trim().isEmpty()) {
        try {
            conn = database.getConnection();
            String sql = "SELECT name FROM product WHERE name LIKE ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + query + "%");
            rs = pstmt.executeQuery();

            while (rs.next()) {
                String productName = rs.getString("name");
%>
                <div class="suggestion-item"><%= productName %></div>
<%
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
