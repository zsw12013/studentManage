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

/**
 * 教师管理
 * 
 * @author 邓晓
 */
@Controller
public class TeacherController {

	private Page page;
	@Autowired
	private Teacher tea;
	@Autowired
	private Evaluate e;
	@Autowired
	private TeacherService dao;

	/**
	 * 添加教师
	 * 
	 * @param tea
	 * @return
	 * @throws Exception
	 *             这种写法返回map会自动封装成json 要写value和method 不然的话就要自己写json返回
	 */
	@RequestMapping(value = "/add_tea.do", method = RequestMethod.POST)
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

	/**
	 * 更新教师
	 * 
	 * @param tea
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/update_tea.do", method = RequestMethod.POST)
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

	/**
	 * 删除教师
	 * 
	 * @param tea
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/del_tea.do", method = RequestMethod.POST)
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

	/**
	 * 所有教师信息
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/show_tea.do")
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
	
	@RequestMapping("/show_evaluate.do")
	@ResponseBody
	public Map showEvaluate(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		//int pageIndex = Integer.parseInt(request.getParameter("page"));
		int total = dao.teacherCount();
		//int pageSize = Integer.parseInt(request.getParameter("rows"));
		//page = new Page(pageIndex, pageSize, total);
		int t_id = Integer.parseInt(request.getParameter("t_id"));
		Map map = new HashMap();
		List<Evaluate> es = null;
		es = dao.selectEvaluateById(t_id);
		Teacher teacher = dao.selectTeacher(t_id);
		map.put("zanNum", teacher.getZanNum());
		map.put("rows", es);
		//map.put("total", total);
		return map;
	}
	
	@RequestMapping("/show_all_evaluate.do")
	@ResponseBody
	public Map showAllEvaluate(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		int pageIndex = Integer.parseInt(request.getParameter("page"));
		int total = dao.evaluateCount();
		int pageSize = Integer.parseInt(request.getParameter("rows"));
		page = new Page(pageIndex, pageSize, total);
		Map map = new HashMap();
		List<Evaluate> es = null;
		es = dao.selectAllEvaluate(e, page);
		map.put("rows", es);
		map.put("total", total);
		// System.out.println(map);
		return map;
	}
	
	@RequestMapping(value = "/del_evaluate.do", method = RequestMethod.POST)
	@ResponseBody
	public Map delete(Evaluate e) throws Exception {
		Map map = new HashMap();
		int i = dao.delEvaluateById(e.getId());
		if (i == 0) {
			map.put("status", "fail");
		} else {
			map.put("status", "success");
		}
		return map;
	}
	
	@RequestMapping(value = "/add_evaluate.do", method = RequestMethod.POST)
	@ResponseBody
	public Map add(Evaluate e) throws Exception {
		Map map = new HashMap();
		int i = dao.addEvaluate(e);
		if (i == 0) {
			map.put("status", "fail");
		} else {
			map.put("status", "success");
		}
		return map;
	}
	
	@RequestMapping(value = "/zanTea.do", method = RequestMethod.POST)
	@ResponseBody
	public Map zan(Evaluate e) throws Exception {
		Map map = new HashMap();
		int i = dao.addZan(e);
		if (i == 0) {
			map.put("status", "fail");
		} else {
			map.put("status", "success");
		}
		return map;
	}
}
