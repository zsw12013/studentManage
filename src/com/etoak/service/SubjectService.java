package com.etoak.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.etoak.entity.Subject;
import com.etoak.entity.Term;


@Service
public interface SubjectService{
	public int addSubject(Subject sub);
	public int delSubjectById(int id);
	public int updateSubjectById(Subject sub);
	public List<Subject> selectSubjects(Subject sub);
	public List<Term> selectTerms();
}
	