package com.etoak.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.etoak.entity.Classes;

@Service
public interface ClassService {
	public List<Classes> showClasses(String id);
	public int disabledById(String id);
	public int updateNode(Classes cls);
	public int addNode(Classes cls);
	public List<Classes> showAllClasses(String id);
	public int openById(String id);
}
