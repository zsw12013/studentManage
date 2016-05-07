package com.etoak.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.etoak.entity.Student;
import com.etoak.page.Page;


@Service
public interface StudentService{
	public int addStudent(Student stu) throws Exception;
	public int delStudentById(String string);
	public int updateStudent(Student stu);
	public List<Student> selectStudentByClassId(Student stu,Page page);
	public List<Student> selectAllStudents(Student stu,Page page,String param);
	public int studentCount();
	public List<Student> selectClass(String id);
	public int batchInsert(List<Student> students);
	public int batchDelete(List students);
	public Student getStudent(String id);
}
	