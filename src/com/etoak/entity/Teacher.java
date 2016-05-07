package com.etoak.entity;

import org.springframework.stereotype.Component;

/**
 * 教师实体
 * 教师和课程绑定(多对多)，课程和班级通过学期绑定（多对多）
 * @author 邓晓
 */
@Component
public class Teacher {
	private Integer id;
	private String name;
	private String email;		
	private Integer zanNum = 0;     //被点赞的次数
	private Integer useType;    //1
	private String workId;   
	private String password;
	
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getWorkId() {
		return workId;
	}
	public void setWorkId(String workId) {
		this.workId = workId;
	}
	public int getId() {
		return id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Integer getZanNum() {
		return zanNum;
	}
	public void setZanNum(Integer zanNum) {
		this.zanNum = zanNum;
	}
	public Integer getUseType() {
		return useType;
	}
	public void setUseType(Integer useType) {
		this.useType = useType;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return "teacher[id="+id+",name="+name+"]";
	}
}
