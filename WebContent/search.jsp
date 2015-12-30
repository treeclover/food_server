<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.HashMap" %>
<%@ page import = "org.json.*, org.json.simple.*" %>

<%
	request.setCharacterEncoding("utf-8");
	JSONArray arr = new JSONArray();
	JSONObject searchObj = new JSONObject();
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;
	
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/appraise", "root", "1234");
		stmt = conn.createStatement();
		//음식점이름 음식이름
		//restautant
		String query1 = "select * from food where name like '%";
		String query2 = "%'";
		String query3 = "select * from restaurant where name like '%";
		String query4 = "%'";
		String search = request.getParameter("search");
		String query = query1 + search + query2;
		String query0 = query3 + search + query4;
		
		rs1 = stmt.executeQuery(query);
		try{
			while (rs1.next()){
				String name = rs1.getString("name");
				String restaurant = rs1.getString("restaurant");

				searchObj = new JSONObject();
				searchObj.put("name", name);
				searchObj.put("restaurant", restaurant);
				if(searchObj != null)
					arr.add(searchObj);
			}
		}catch (SQLException e){
			out.println("sql에러");
		}
		rs2 = stmt.executeQuery(query0);
		try{
			while (rs2.next()){
				String name = rs2.getString("name");
				String restaurant = rs2.getString("restaurant");

				searchObj = new JSONObject();
				searchObj.put("name", name);
				searchObj.put("restaurant", restaurant);
				if(searchObj != null)
					arr.add(searchObj);
			}
			out.print(arr);
			
		}catch(SQLException e){
			out.println("sql에러");
		}
	}catch (Exception e){
			out.println("에러");
	}
%>
