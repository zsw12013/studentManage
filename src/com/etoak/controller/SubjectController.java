package com.etoak.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.etoak.entity.Student;
import com.etoak.entity.Subject;
import com.etoak.entity.Term;
import com.etoak.service.SubjectService;

/**
 * 课程管理
 * 
 * @author 邓晓
 */
@Controller
public class SubjectController {
	@Autowired
	private SubjectService dao;

	@RequestMapping("/show_sub.do")
	@ResponseBody
	public Map showSubjects(Subject sub) throws Exception {
		Map map = new HashMap();
		List<Subject> subjects = dao.selectSubjects(sub);
		map.put("rows", subjects);
		return map;
	}

	@RequestMapping("/show_term.do")
	@ResponseBody
	public Object showTerms(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Map map = new HashMap();
		List<Term> terms = dao.selectTerms();
		JSONArray ja = JSONArray.fromObject(terms);
		return ja;
	}
	
	@RequestMapping("/update_sub")
	@ResponseBody
	public Map UpdateSubject(Subject sub) throws Exception{
		Map map = new HashMap();
		int i = dao.updateSubjectById(sub);
		if(i==0){
			map.put("status", "error");
		}else{
			map.put("status", "success");
		}
		return map;
	}
	
	@RequestMapping("/del_sub.do")
	@ResponseBody
	public Map deleteSubject(Subject sub) throws Exception {
		Map map = new HashMap();
		int i = dao.delSubjectById(sub.getId());
		if (i == 0) {
			map.put("status", "fail");
		} else {
			map.put("status", "success");
		}
		return map;
	}
	
	@RequestMapping("/add_sub.do")
	@ResponseBody
	public Map addSubject(Subject sub) throws Exception {
		Map map = new HashMap();
		int i = dao.addSubject(sub);
		if (i == 0) {
			map.put("status", "fail");
		} else {
			map.put("status", "success");
		}
		return map;
	}
}
