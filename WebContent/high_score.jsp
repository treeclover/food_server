<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.sql.*, java.io.*" %>
<%@ page import = "java.util.HashMap" %>
<%@ page import = "org.json.*, org.json.simple.*" %>
<%
	request.setCharacterEncoding("utf-8");
	JSONObject messages = new JSONObject();
	JSONArray array = new JSONArray();
	Connection conn = null;
	Statement stmt = null;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/appraise", "root", "1234");
		if (conn == null)
			throw new Exception("데이터베이스에 연결할 수 없습니다.<BR>");
		stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("select name, price, restaurant, total, img from food order by total desc limit 10;");
		while (rs.next()) {
			messages = new JSONObject();
			messages.put("name", rs.getString("name"));
			messages.put("price", rs.getInt("price"));
			messages.put("restaurant", rs.getString("restaurant"));
			messages.put("total", rs.getFloat("total"));
			messages.put("imgpath", rs.getString("img"));
			array.add(messages);
		}
		out.print(array);
	} catch (SQLException e) {
		out.println("작성된 데이터가 존재하지 않습니다.");
	} catch (IOException e) {
		out.println("작성된 데이터가 존재하지 않습니다.");
	} finally {
		try {
			stmt.close();
		} catch (Exception ignored) {
		}
		try {
			conn.close();
		} catch (Exception ignored) {
		}
	}
%>