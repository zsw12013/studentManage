package com.etoak.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.etoak.dao.ClassDaoIf;
import com.etoak.entity.Classes;

@Service
public class ClassServiceImpl implements ClassService {

	@Autowired
	private ClassDaoIf dao;
	
	@Override
	public List<Classes> showClasses(String id) {
		return dao.showClasses(id);
	}

	@Override
	public int disabledById(String id) {
		return dao.disabledById(id);
	}

	@Override
	public int updateNode(Classes cls) {
		return dao.updateNode(cls);
	}

	@Override
	public int addNode(Classes cls) {
		return dao.addNode(cls);
	}

	@Override
	public List<Classes> showAllClasses(String id) {
		return dao.showAllClasses(id);
	}

	@Override
	public int openById(String id) {
		return dao.openById(id);
	}
	
}
