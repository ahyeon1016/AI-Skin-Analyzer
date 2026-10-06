package com.spring.repository;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class DBConnection {

	public static Connection getConnection() throws SQLException, ClassNotFoundException 
	{
	    Connection conn = null;

	    // 실제 DB 접속 정보는 src/main/resources/secret-config.txt에서 불러옴 (Git 제외)
	    Properties secretConfig = new Properties();
	    try (InputStream input = DBConnection.class.getClassLoader().getResourceAsStream("secret-config.txt")) {
	        if (input == null) {
	            throw new SQLException("secret-config.txt 파일을 찾을 수 없습니다.");
	        }
	        secretConfig.load(input);
	    } catch (IOException e) {
	        throw new SQLException("secret-config.txt 파일을 읽을 수 없습니다.", e);
	    }

	    String url = secretConfig.getProperty("DB_URL");
        String user = secretConfig.getProperty("DB_USER");
        String password = secretConfig.getProperty("DB_PASSWORD");

	    Class.forName("org.mariadb.jdbc.Driver"); // 또는 com.mysql.cj.jdbc.Driver
	    conn = DriverManager.getConnection(url, user, password);
	    System.out.println("데이터베이스가 연결되었습니다.");
	    return conn;
	}
}
