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

import com.etoak.entity.Classes;
import com.etoak.entity.Student;
import com.etoak.page.Page;
import com.etoak.service.ClassService;
/**
 * 学院-专业-班级 树操作
 * @author 邓晓
 */
@Controller
public class ClassController {
	
	private Page page;
	
	@Autowired
	private Classes cs;
	
	@Autowired
	private ClassService dao;

	/**
	 * 异步加载树
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/show_classes.do")
	@ResponseBody
	public List showClasses(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String id = request.getParameter("id");
		Map map = new HashMap();
		List<Classes> classes = dao.showClasses(id);
		map.put("clild",classes);
		//System.out.println(map);
		return classes;
	}
	/**
	 * 更新节点名称
	 * @param cls
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/update_node.do",method = RequestMethod.POST)
	@ResponseBody
	public Map updateNode(Classes cls) throws Exception{
		Map map = new HashMap();
		int i = dao.updateNode(cls);
	    if(i==0){
	    	map.put("status","fail");
	    }else{
	    	map.put("status","success");
	    }
		return map;
	}
	/**
	 * 停用节点
	 * @param cls
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/disabled_node.do",method = RequestMethod.POST)
	@ResponseBody
	public Map disabledNode(Classes cls) throws Exception{
		Map map = new HashMap();
		int i = dao.disabledById(cls.getId());
	    if(i==0){
	    	map.put("status","fail");
	    }else{
	    	map.put("status","success");
	    }
		return map;
	}
	
	/**
	 * 启用节点
	 * @param cls
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/open_node.do",method = RequestMethod.POST)
	@ResponseBody
	public Map openNode(Classes cls) throws Exception{
		Map map = new HashMap();
		int i = dao.openById(cls.getId());
	    if(i==0){
	    	map.put("status","fail");
	    }else{
	    	map.put("status","success");
	    }
		return map;
	}
	/**
	 * 添加节点
	 * @param cls
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/add_node.do",method = RequestMethod.POST)
	@ResponseBody
	public Map addNode(Classes cls) throws Exception{
		Map map = new HashMap();
		int i = dao.addNode(cls);
	    if(i==0){
	    	map.put("status","fail");
	    }else{
	    	map.put("status","success");
	    }
		return map;
	}
	
	@RequestMapping("/show_allclasses.do")
	@ResponseBody
	public List showAllClasses(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String id = request.getParameter("id");
		Map map = new HashMap();
		List<Classes> classes = dao.showAllClasses(id);
		map.put("clild",classes);
		//System.out.println(map);
		return classes;
	}
}
