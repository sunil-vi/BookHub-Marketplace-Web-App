package com.bookhub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.bookhub.util.DBUtil;
import com.bookhub.util.EmailPassUtil;

public class UserDao {

	public boolean isValidUser(String email) {
		
		
		// TODO Auto-generated method stub
		String query = "SELECT * FROM user WHERE email = ?";
		try (Connection connection = DBUtil.getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(query)) {

			preparedStatement.setString(1, email);

			ResultSet resultSet = preparedStatement.executeQuery();
//           System.out.println("in userDaoimpl class after connection ");
			return resultSet.next();

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}

	}

	public boolean addUser(User user) {
		// TODO Auto-generated method stub
		String query = "INSERT INTO user (fname, lname , email , phno , password) VALUES (?,?,?,?,?)";

		try (Connection connection = DBUtil.getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(query);
		) {



			preparedStatement.setString(1, user.getFname());
			preparedStatement.setString(2, user.getLname());
			preparedStatement.setString(3, user.getEmail());
			preparedStatement.setString(4, user.getPhno());
			
			String encryptedPass = EmailPassUtil.encrypt(user.getPassword());
			preparedStatement.setString(5, encryptedPass);

			int rows = preparedStatement.executeUpdate();

			// System.out.println("User data inserted using userDao class and interface ");
			return rows > 0;

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}

	}

	public boolean isUserPresent(String email) {
		String query = "SELECT * FROM user WHERE email = ?";
		try (Connection connection = DBUtil.getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(query)) {

			preparedStatement.setString(1, email);
			

			ResultSet resultSet = preparedStatement.executeQuery();
//           System.out.println("in userDaoimpl class after connection ");
			return resultSet.next();

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}

	}
	
	public User getUser(String email,String password)
	{
		User user = new User();
		String query = "SELECT * FROM user WHERE email = ? AND password = ?";
		try (Connection connection = DBUtil.getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(query)) {

			preparedStatement.setString(1, email);
				password = EmailPassUtil.encrypt(password);
				
				//System.out.println("Encrypted Password" + password);
			preparedStatement.setString(2, password);

			ResultSet resultSet = preparedStatement.executeQuery();
//           System.out.println("in userDao class after connection ");
			if (resultSet.next()) {
				user.setId(resultSet.getInt(1));
				user.setFname(resultSet.getString(2));
				user.setLname(resultSet.getString(3));
				user.setEmail(resultSet.getString(4));
				user.setPhno(resultSet.getString(5));
				user.setPassword(resultSet.getString(6));
				user.setB_bought(resultSet.getInt(7));
				user.setB_sold(resultSet.getInt(8));
				user.setJoin_date(resultSet.getString(9));
				user.setImage(resultSet.getString(10));
				user.setAddress(resultSet.getString(11));
			}

		} catch (SQLException e) {
			e.printStackTrace();
			
		}
		return user;
	}
}


