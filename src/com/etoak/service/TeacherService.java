package com.etoak.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.etoak.entity.Evaluate;
import com.etoak.entity.Teacher;
import com.etoak.page.Page;


@Service
public interface TeacherService{
public int addTeacher(Teacher tea);
	public int delTeacherById(int i);
	public int updateTeacher(Teacher tea);
	public int updatePassword(int id);
	public Teacher selectTeacher(int id);
	public List<Teacher> selectAllTeachers(Teacher tea,Page page);  
	public int teacherCount();
	public List<Evaluate> selectEvaluateById(int id);
	public List<Evaluate> selectAllEvaluate(Evaluate e,Page page);  
	public int evaluateCount();
	public int delEvaluateById(int i);
	public int addEvaluate(Evaluate e);
	public int addZan(Evaluate e);
}
	