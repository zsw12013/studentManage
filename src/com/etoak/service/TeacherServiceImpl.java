package com.etoak.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.etoak.dao.TeacherDaoIf;
import com.etoak.entity.Evaluate;
import com.etoak.entity.Teacher;
import com.etoak.page.Page;
import com.etoak.page.SearchPageUtil;

@Service
public class TeacherServiceImpl implements TeacherService {

	@Autowired
	private TeacherDaoIf dao;

	@Override
	public int addTeacher(Teacher tea) {
		return dao.addTeacher(tea);
	}

	@Override
	public int delTeacherById(int id) {
		return dao.delTeacherById(id);
	}

	@Override
	public int updateTeacher(Teacher tea) {
		return dao.updateTeacher(tea);
	}

	@Override
	public int updatePassword(int id) {
		return dao.updatePassword(id);
	}

	@Override
	public Teacher selectTeacher(int id) {
		return dao.selectTeacher(id);
	}

	@Override
	public List<Teacher> selectAllTeachers(Teacher tea,Page page) {
		SearchPageUtil searchPageUtil = new SearchPageUtil();
		String a[] = { "zanNum  desc"};
		searchPageUtil.setOrderBys(a);
		searchPageUtil.setPage(page);
		searchPageUtil.setObject(tea);
		final List list = dao.selectAllTeachers(searchPageUtil);
		return list;
	}

	@Override
	public int teacherCount() {
		return dao.teacherCount();
	}

	@Override
	public List<Evaluate> selectEvaluateById(int id) {
		return dao.selectEvaluateById(id);
	}

	@Override
	public List<Evaluate> selectAllEvaluate(Evaluate e, Page page) {
		SearchPageUtil searchPageUtil = new SearchPageUtil();
		String a[] = { ""};
		searchPageUtil.setOrderBys(a);
		searchPageUtil.setPage(page);
		searchPageUtil.setObject(e);
		final List list = dao.selectAllEvaluates(searchPageUtil);
		return list;
	}

	@Override
	public int evaluateCount() {
		return dao.evaluateCount();
	}

	@Override
	public int delEvaluateById(int id) {
		return dao.delEvaluateById(id);
	}

	@Override
	public int addEvaluate(Evaluate e) {
		Evaluate evaluate = dao.getEvaluate(e);
		int i = 0;
		if(evaluate!=null){
			e.setId(evaluate.getId());
			i = dao.updateEvaluate(e);
		}else{
			i = dao.addEvaluate(evaluate);
		}
		return i;
	}

	@Override
	public int addZan(Evaluate e) {
		Evaluate evaluate;
		evaluate = dao.getZan(e);
		int i = 0;
		if(evaluate!=null){
			if(evaluate.getZan()!=null&&evaluate.getZan()==1){
				i = 0;
			}else{
				e.setId(evaluate.getId());
				i = dao.updateZan(e);
				dao.updateTeaZan(e.getT_id());
			}
		}else{
			i = dao.addZan(e);
			dao.updateTeaZan(e.getT_id());
		}
		return i;
	}

	

}
