package com.etoak.entity;

import org.springframework.stereotype.Component;

@Component
public class Subject {
	private int id;
	private String classid;		//班级id
	private int termid;     //学期id
	private String subject;    //课程名
	private String teacher;   //教师名
	private String remark;		//备注
	private String classroom;  //教室
	
	
	public String getTeacher() {
		return teacher;
	}
	public void setTeacher(String teacher) {
		this.teacher = teacher;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getClassroom() {
		return classroom;
	}
	public void setClassroom(String classroom) {
		this.classroom = classroom;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getClassid() {
		return classid;
	}
	public void setClassid(String classid) {
		this.classid = classid;
	}
	public int getTermid() {
		return termid;
	}
	public void setTermid(int termid) {
		this.termid = termid;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	
}
