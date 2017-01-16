import java.sql.*;

public class test {

	public static void main(String[] args) {
		try {
			Connection con = null;

			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/testdb",
					"root", "1234");

			java.sql.Statement st = null;
			ResultSet rs = null;
			st = con.createStatement();
			rs = st.executeQuery("SELECT * FROM lists");

			while (rs.next()) {
				String str = rs.getString(1)+"\t"+rs.getString(2)+"\t"+rs.getString(4);
				//int str = rs.getInt(1);
				System.out.println(str);
			}
			
		} catch (SQLException sqex) {
			System.out.println("SQLException: " + sqex.getMessage());
			System.out.println("SQLState: " + sqex.getSQLState());
		}

	}
}