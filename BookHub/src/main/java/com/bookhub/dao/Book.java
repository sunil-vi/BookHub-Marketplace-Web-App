package com.bookhub.dao;

public class Book {
	private int id,bsold,price;
	private String bname,author,image,pdf,tags,bdesc,cat_name;
	
	public Book() {
	
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getBsold() {
		return bsold;
	}

	public void setBsold(int bsold) {
		this.bsold = bsold;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getBname() {
		return bname;
	}

	public void setBname(String bname) {
		this.bname = bname;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getPdf() {
		return pdf;
	}

	public void setPdf(String pdf) {
		this.pdf = pdf;
	}

	public String getTags() {
		return tags;
	}

	public void setTags(String tags) {
		this.tags = tags;
	}

	public String getBdesc() {
		return bdesc;
	}

	public void setBdesc(String bdesc) {
		this.bdesc = bdesc;
	}

	public String getCat_name() {
		return cat_name;
	}

	public void setCat_name(String cat_name) {
		this.cat_name = cat_name;
	}

	@Override
	public String toString() {
		return "Book [id=" + id + ", bsold=" + bsold + ", price=" + price + ", bname=" + bname + ", author=" + author
				+ ", image=" + image + ", pdf=" + pdf + ", tags=" + tags + ", bdesc=" + bdesc + ", cat_name=" + cat_name
				+ "]";
	}

	
	
	
}
