package com.etoak.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.etoak.dao.StudentDaoIf;
import com.etoak.entity.Student;
import com.etoak.exception.AddException;
import com.etoak.page.Page;
import com.etoak.page.SearchPageUtil;

@Service
public class StudentServiceImpl implements StudentService {

	@Autowired
	private StudentDaoIf dao;
	
	@Override
	public int addStudent(Student stu) throws Exception {
		return dao.addStudent(stu);
	}

	@Override
	public int delStudentById(String id) {
		return dao.delStudentById(id);
	}

	@Override
	public int updateStudent(Student stu) {
		return dao.updateStudent(stu);
	}

	@Override
	public List<Student> selectStudentByClassId(Student stu,Page page) {
		SearchPageUtil searchPageUtil = new SearchPageUtil();
		String a[] = { "name  desc", "id asc" };
		searchPageUtil.setOrderBys(a);
		searchPageUtil.setPage(page);
		searchPageUtil.setObject(stu);
		List<Student> list = dao.selectStudentByClassId(searchPageUtil,stu);
		//System.out.println(list);
		return list ;
	}

	@Override
	public List<Student> selectAllStudents(Student stu,Page page,String param) {
		SearchPageUtil searchPageUtil = new SearchPageUtil();
		String a[] = { "name  desc", "id asc" };
		searchPageUtil.setOrderBys(a);
		searchPageUtil.setPage(page);
		searchPageUtil.setObject(stu);
		final List list = dao.selectAllStudents(searchPageUtil,param);
		return list;
	}

	@Override
	public int studentCount() {
		return dao.studentCount();
	}

	@Override
	public List<Student> selectClass(String id) {
		return dao.selectClass(id);
	}
	
	@Override
	public int batchInsert(List<Student> students) {
		return dao.batchInsert(students);
	}

	@Override
	public int batchDelete(List students) {
		return dao.batchDelete(students);
	}

	@Override
	public Student getStudent(String id) {
		return dao.getStudent(id);
	}

}
