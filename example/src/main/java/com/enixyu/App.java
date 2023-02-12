package com.enixyu;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;

/**
 * Hello world!
 */
public class App {

  public static void main(String[] args) {
    try {
      Class.forName("com.taosdata.jdbc.TSDBDriver");
      String jdbcUrl = "jdbc:TAOS://tdengine:6030/test?user=root&password=taosdata";
      Connection conn = DriverManager.getConnection(jdbcUrl);

      Statement stmt = conn.createStatement();
      // create database
      stmt.executeUpdate("create database if not exists db");
      // use database
      stmt.executeUpdate("use db");
      // create table
      stmt.executeUpdate(
        "create table if not exists tb (ts timestamp, temperature int, humidity float)");
      // insert data
      int affectedRows = stmt.executeUpdate(
        "insert into tb values(now, 23, 10.3) (now + 1s, 20, 9.3)");

      System.out.println("insert " + affectedRows + " rows.");

      // query data
      ResultSet resultSet = stmt.executeQuery("select * from tb");
      Timestamp ts = null;
      int temperature = 0;
      float humidity = 0;
      while (resultSet.next()) {
        ts = resultSet.getTimestamp(1);
        temperature = resultSet.getInt(2);
        humidity = resultSet.getFloat("humidity");

        System.out.printf("%s, %d, %s\n", ts, temperature, humidity);
      }
    } catch (ClassNotFoundException e) {
      System.out.println("JDBC driver not found");
      e.printStackTrace();
    } catch (SQLException e) {
      System.out.println("failed to get connection");
      e.printStackTrace();
    }
  }
}
