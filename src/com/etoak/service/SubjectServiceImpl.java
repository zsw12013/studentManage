package com.etoak.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.etoak.dao.SubjectDaoIf;
import com.etoak.entity.Subject;
import com.etoak.entity.Term;

@Service
public class SubjectServiceImpl implements SubjectService {

	@Autowired
	private SubjectDaoIf dao;
	
	@Override
	public int addSubject(Subject sub) {
		return dao.addSubject(sub);
	}

	@Override
	public int delSubjectById(int id) {
		return dao.delSubjectById(id);
	}

	@Override
	public List<Subject> selectSubjects(Subject sub) {
		return dao.selectSubjects(sub);
	}
	
	@Override
	public List<Term> selectTerms() {
		return dao.selectTerms();
	}

	@Override
	public int updateSubjectById(Subject sub) {
		return dao.updateSubjectById(sub);
	}

}
