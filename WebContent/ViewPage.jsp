<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.sql.*, java.io.*" %>
<%
	request.setCharacterEncoding("utf-8");
	String name = null, restaurant = null, img = null;
	int price = 0;
	float total = 0;
	int pagenum = 1;
	if(request.getParameter("page") != null) {
		pagenum = Integer.parseInt(request.getParameter("page"));
	}
	Connection conn = null;
	Statement stmt = null;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/appraise", "root", "1234");
		if (conn == null)
			throw new Exception("데이터베이스에 연결할 수 없습니다.<BR>");
		stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("select * from food order by total desc limit " + ((pagenum-1)*5) + ", 5;");
		while (rs.next()) {
			name = rs.getString("name");
			price = rs.getInt("price");
			restaurant = rs.getString("restaurant");
			total = rs.getFloat("total");
			img = rs.getString("img");
%>
<HTML>
	<HEAD>
		<META http-equiv="Content-Type" content="text/html; charset=utf-8">
		<TITLE>페이징 출력</TITLE>
	</HEAD>
	<BODY>
		<img  src="<%= img %>" alt=""/><BR>
		이름 : <%= name %><BR>
		가격 : <%= price %><BR>
		점포 : <%= restaurant %><BR>
		평점 : 5점 만점 중 '<%= total %>'<BR><BR><BR>
<%
		}
	} catch (SQLException e) {
		out.println("작성된 방명록이 존재하지 않습니다.");
	} catch (IOException e) {
		out.println("작성된 방명록이 존재하지 않습니다.");
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
		<FORM action="ViewPage.jsp" method=POST>
			<input type=submit name=page value=1>
		</FORM>
		<FORM action="ViewPage.jsp" method=POST>
			<input type=submit name=page value=2>
		</FORM>
		<FORM action="ViewPage.jsp" method=POST>
			<input type=submit name=page value=3>
		</FORM>
	</BODY>
</HTML>