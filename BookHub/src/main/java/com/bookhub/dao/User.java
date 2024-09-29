package com.bookhub.dao;

public class User {
	private String fname;
	private String lname;
	private String email;
	private String phno;
	private String password;
	private String join_date;
	private String image;
	private String address;
	private int b_bought,b_sold;
	
	
	private int id;
	
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	public String getLname() {
		return lname;
	}
	public void setLname(String lname) {
		this.lname = lname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhno() {
		return phno;
	}
	public void setPhno(String phno) {
		this.phno = phno;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getId() {
		// TODO Auto-generated method stub
		return id;
	}
	public void setId(int id) {
		this.id = id;	
	}
	public String getJoin_date() {
		return join_date;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public void setJoin_date(String join_date) {
		this.join_date = join_date;
	}
	public int getB_bought() {
		return b_bought;
	}
	public void setB_bought(int b_bought) {
		this.b_bought = b_bought;
	}
	public int getB_sold() {
		return b_sold;
	}
	public void setB_sold(int b_sold) {
		this.b_sold = b_sold;
	}
	
	

}
