package com.etoak.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.etoak.dao.LoginDaoIf;
import com.etoak.entity.Student;
import com.etoak.entity.SystemUser;
import com.etoak.entity.Teacher;

@Service
public class LoginServiceImpl implements LoginService {

	@Autowired
	private LoginDaoIf dao;

	@Override
	public Student checkStudent(Map<String, String> map) {
		return dao.checkStudent(map);
	}

	@Override
	public Teacher checkTeacher(Map<String, String> map) {
		return dao.checkTeacher(map);
	}

	@Override
	public SystemUser checkSystemUser(Map<String, String> map) {
		return dao.checkSystemUser(map);
	}

	@Override
	public int updateStuPassword(Map<String, Object> map) {
		return dao.updateStuPassword(map);
	}

	@Override
	public int updateTeaPassword(Map<String, Object> map) {
		return dao.updateTeaPassword(map);
	}

	@Override
	public int updateSystemPassword(Map<String, Object> map) {
		return dao.updateSystemPassword(map);
	}


}
