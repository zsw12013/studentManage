package com.etoak.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.etoak.entity.Student;
import com.etoak.entity.SystemUser;
import com.etoak.entity.Teacher;


@Service
public interface LoginService{
	public Student checkStudent(Map<String,String> map);
	public Teacher checkTeacher(Map<String,String> map);
	public SystemUser checkSystemUser(Map<String,String> map);
	
	public int updateStuPassword(Map<String,Object> map);
	public int updateTeaPassword(Map<String,Object> map);
	public int updateSystemPassword(Map<String,Object> map);
}
	