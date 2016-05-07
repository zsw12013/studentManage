package com.etoak.test;

import java.util.ArrayList;
import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import com.etoak.dao.StudentDaoIf;
import com.etoak.entity.Student;

public class TestMybatis {
	public static void main(String[] args) throws Exception {
		 ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
		  ac = new FileSystemXmlApplicationContext("src/applicationContext.xml");
	
		  StudentDaoIf sdao = (StudentDaoIf)ac.getBean("studentDaoIf");
		List<Student> students = new ArrayList<Student>();
		Student stu = new Student();
		stu.setId("112111");
		stu.setName("aa");
		students.add(stu);
		sdao.batchInsert(students);
		
	}
}
