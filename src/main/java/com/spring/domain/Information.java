package com.spring.domain;

import org.springframework.web.multipart.MultipartFile;

public class Information {
	private String skintype;
	private String question;
	private MultipartFile photo;
	
	public String getSkintype() {
		return skintype;
	}
	public void setSkintype(String skintype) {
		this.skintype = skintype;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public MultipartFile getPhoto() {
		return photo;
	}
	public void setPhoto(MultipartFile photo) {
		this.photo = photo;
	}
}
