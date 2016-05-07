package com.etoak.entity;

import org.springframework.stereotype.Component;

/**
 * 教师评价、点赞实体 一个学生对一个老师只能有一条评价，一个赞
 * 
 * @author 邓晓
 */
@Component
public class Evaluate {
	private Integer id;
	private Integer t_id; // 被评价的教师
	private String name; // 被评教师姓名
	private String s_id; // 评价的学生
	private String content; // 评价的内容
	private Integer zan; // 点赞 1 | 0
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getT_id() {
		return t_id;
	}

	public void setT_id(Integer t_id) {
		this.t_id = t_id;
	}

	public String getS_id() {
		return s_id;
	}

	public void setS_id(String s_id) {
		this.s_id = s_id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Integer getZan() {
		return zan;
	}

	public void setZan(Integer zan) {
		this.zan = zan;
	}

}
