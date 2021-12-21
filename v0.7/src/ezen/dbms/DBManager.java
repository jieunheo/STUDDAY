package ezen.dbms;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBManager
{
	private Connection conn   = null;

	private String host   = ""; //dburl
	private String userid = ""; //id
	private String userpw = ""; //pw

	private Statement  stmt   = null;
	private ResultSet  result = null;
	
	private boolean  isMonitering = true;

	public DBManager()
	{
		host   = "jdbc:mysql://localhost:3306/studdaydb?useUnicode=ture&characterEncoding=utf-8&serverTimezone=UTC";
		userid = "root";
		userpw = "ezen";
	}

	//setter
	public void setHost(String host) 	 { this.host   = host;   }
	public void setUserid(String userid) { this.userid = userid; }
	public void setUserpw(String userpw) { this.userpw = userpw; }
	
	//성공-true, 실패-false
	public boolean DBOpen()
	{
		try
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			conn = DriverManager.getConnection(host, userid, userpw);
		} catch (ClassNotFoundException e)
		{
			//Class.forName()
			e.printStackTrace();
			return false;
		} catch (SQLException e)
		{
			//DriverManager.getConnection()
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	//DB 닫기
	public void DBClose()
	{
		try
		{
			conn.close();
		} catch (SQLException e)
		{
			//DriverManager.getConnection()
			e.printStackTrace();
		}
	}
	
	//Insert, Update, Delete
	public boolean RunSQL(String sql)
	{
		if (isMonitering)
		{
			System.out.println("==========================");
			System.out.println(sql);
			System.out.println("==========================");
		}
		
		try
		{
			stmt = conn.createStatement();
			
			stmt.executeUpdate(sql);
			stmt.close();
		} catch (Exception e)
		{
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	//select SQL 열기
	public boolean OpenQuery(String sql)
	{
		if (isMonitering)
		{
			System.out.println("==========================");
			System.out.println(sql);
			System.out.println("==========================");
		}
		
		try
		{
			stmt = conn.createStatement();
			result = stmt.executeQuery(sql);
		} catch (Exception e)
		{
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	//select SQL 닫기
	public void CloseQuery()
	{
		try
		{
			result.close();
			stmt.close();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	
	//select SQL 내용
	public boolean GetNext()
	{
		try
		{
			return result.next();
		} catch (SQLException e)
		{
			e.printStackTrace();
			return false;
		}
	}
	
	//select SQL 문자값 가져오기
	public String GetValue(String culumn)
	{
		try
		{
			return result.getString(culumn);
		} catch (SQLException e)
		{
			e.printStackTrace();
			return null;
		}
	}
	
	//select SQL 숫자값 가져오기
	public int GetInteger(String culumn)
	{
		try
		{
			return result.getInt(culumn);
		} catch (SQLException e)
		{
			e.printStackTrace();
			return 0;
		}
	}
	
	//Last Id
	public String GetLastID(String value) {
		String sql = "select last_insert_id() as " + value + " ";
		String id = "";
		try
		{
			ResultSet result = stmt.executeQuery(sql);
			result = stmt.executeQuery(sql);
			if (result.next() == true)
			{
				id = result.getString(value);
			}
			result.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return id;
	}
	
	public static void main(String args[])
	{
	
	}
}