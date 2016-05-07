package com.etoak.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.etoak.entity.Evaluate;
import com.etoak.entity.Teacher;
import com.etoak.page.Page;
import com.etoak.service.TeacherService;

@Controller
public class TestController {
	private Page page;
	@Autowired
	private Teacher tea;
	@Autowired
	private Evaluate e;
	@Autowired
	private TeacherService dao;
	
	
	@RequestMapping("/get_users.do")
	@ResponseBody
	public Map showStudents(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		int pageIndex = Integer.parseInt(request.getParameter("page"));
		int total = dao.teacherCount();
		int pageSize = Integer.parseInt(request.getParameter("rows"));
		page = new Page(pageIndex, pageSize, total);
		String param = request.getParameter("param");
		Map map = new HashMap();
		List<Teacher> teachers = null;
		teachers = dao.selectAllTeachers(tea, page);
		map.put("rows", teachers);
		map.put("total", total);
		// System.out.println(map);
		return map;
	}
	
	/**
	 * 更新教师
	 * 
	 * @param tea
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/update_user.do", method = RequestMethod.POST)
	@ResponseBody
	public Map update(Teacher tea) throws Exception {
		Map map = new HashMap();
		int i = dao.updateTeacher(tea);
		if (i == 0) {
			map.put("status", "fail");
		} else {
			map.put("status", "success");
		}
		return map;
	}
	
	@RequestMapping(value = "/save_user.do", method = RequestMethod.POST)
	@ResponseBody
	public Map add(Teacher tea) throws Exception {
		Map map = new HashMap();
		int i = dao.addTeacher(tea);
		if (i == 0) {
			map.put("status", "fail");
		} else {
			map.put("status", "success");
		}
		return map;
	}
	
	@RequestMapping(value = "/destroy_user.do", method = RequestMethod.POST)
	@ResponseBody
	public Map delete(Teacher tea) throws Exception {
		Map map = new HashMap();
		int i = dao.delTeacherById(tea.getId());
		if (i == 0) {
			map.put("status", "fail");
		} else {
			map.put("status", "success");
		}
		return map;
	}
}
