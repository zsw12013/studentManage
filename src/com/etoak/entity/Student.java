package com.etoak.entity;

import org.springframework.stereotype.Component;

/**
 * 学生实体
 * 
 * @author 邓晓
 */
@Component
public class Student {

	private String id; // 学号
	private String name;
	private String birth;
	private Integer age; // 选择出生日期后自动计算出年龄
	private String sex;
	private String address;
	private String tel;
	private String email;
	private String classid; // 外键 与 classes表id关联
	private String classname;
	private String password; // 登录密码
	private Integer userType; // 自动存储为 2 [学生]

	// 其他非必填信息，用来完善简历，老师不可查看：
	private String favorite = ""; // 爱好
	private String describe = ""; // 个人描述
	private String reward = ""; // 获奖情况

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getClassname() {
		return classname;
	}

	public void setClassname(String classname) {
		this.classname = classname;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public Integer getAge() {
		return age;
	}

	public void setAge(Integer age) {
		this.age = age;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getClassid() {
		return classid;
	}

	public void setClassid(String classid) {
		this.classid = classid;
	}

	public Integer getUserType() {
		return userType;
	}

	public void setUserType(Integer userType) {
		this.userType = userType;
	}

	public String getFavorite() {
		return favorite;
	}

	public void setFavorite(String favorite) {
		this.favorite = favorite;
	}

	public String getDescribe() {
		return describe;
	}

	public void setDescribe(String describe) {
		this.describe = describe;
	}

	public String getReward() {
		return reward;
	}

	public void setReward(String reward) {
		this.reward = reward;
	}

	public Student() {
		super();
	}

	@Override
	public String toString() {
		return "Student [id=" + id + ", name=" + name + ", birth=" + birth
				+ ", age=" + age + ", sex=" + sex + ", address=" + address
				+ ", tel=" + tel + ", email=" + email + ", classid=" + classid
				+ ", classname=" + classname + ", password=" + password
				+ ", userType=" + userType + "]";
	}



}
