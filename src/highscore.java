
import java.io.*;
import java.sql.*;

import javax.servlet.*;
import javax.servlet.http.*;

import org.json.simple.*;

public class highscore extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doOut(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doOut(request, response);
	}

	protected void doOut(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		JSONObject messages = new JSONObject();
		JSONArray array = new JSONArray();
		DBconn(messages, array);
		PrintWriter out = response.getWriter();
		out.print(array);
	}
	
	void DBconn(JSONObject jso, JSONArray jsa) throws ServletException, IOException {
		Connection conn = null;
		Statement stmt = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/appraise", "root", "1234");
			if (conn == null)
				throw new Exception("데이터베이스에 연결할 수 없습니다.<BR>");
			stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select name, price, restaurant, total, img from food order by total desc limit 5;");
			while (rs.next()) {
				jso = new JSONObject();
				jso.put("name", rs.getString("name"));
				jso.put("price", rs.getInt("price"));
				jso.put("restaurant", rs.getString("restaurant"));
				jso.put("total", rs.getFloat("total"));
				jso.put("img", rs.getString("img"));
				jsa.add(jso);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
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
	}
}
