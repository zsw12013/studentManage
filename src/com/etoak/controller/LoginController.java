package com.etoak.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.etoak.entity.Student;
import com.etoak.entity.SystemUser;
import com.etoak.entity.Teacher;
import com.etoak.service.LoginService;
@Controller
public class LoginController {
	
	@Autowired
	private LoginService dao;
	
	/**
	 * 登录验证
	 * @Title  updateNode 
	 * @Description  TODO(描述该方法...) 
	 * @date  2015-12-27 下午2:25:24
	 * @author  Administrator
	 * @modifier  Administrator
	 * @modifydate  2015-12-27 下午2:25:24
	 * @param cls
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/login.do",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> login(String loginName,String password,String type,HttpServletRequest request) throws Exception{
		Map<String, String> map = new HashMap<String,String>();
		Map<String, String> result = new HashMap<String,String>();
		HttpSession session=request.getSession();
		map.put("id", loginName);
		map.put("password", password);
		int userType = 0 ;
		if(type!=null&&!"".equals(type)){
			userType = Integer.parseInt(type);
		}
		if(userType == 0 ){
			SystemUser  su = dao.checkSystemUser(map);
			if(su!=null){
				session.setAttribute("userType", "0");
				session.setAttribute("name", su.getName());
				session.setAttribute("id", su.getId());
				session.setAttribute("password", su.getPassword());
				result.put("status","success");
			}
		}else if(userType ==1){
			Teacher te = dao.checkTeacher(map);
			if(te!=null){
				session.setAttribute("userType", "1");
				session.setAttribute("name", te.getName());
				session.setAttribute("id", te.getId());
				session.setAttribute("password", te.getPassword());
				result.put("status","success");
			}
		}else if(userType == 2){
			Student st = dao.checkStudent(map);
			if(st!=null){
				session.setAttribute("userType", "2");
				session.setAttribute("name", st.getName());
				session.setAttribute("id", st.getId());
				session.setAttribute("address", st.getAddress());
				session.setAttribute("tel", st.getTel());
				session.setAttribute("email", st.getEmail());
				session.setAttribute("sex", st.getSex());
				session.setAttribute("birth", st.getBirth());
				session.setAttribute("favorite", st.getFavorite());
				session.setAttribute("describe", st.getDescribe());
				session.setAttribute("reward", st.getReward());
				session.setAttribute("classid", st.getClassid());
				session.setAttribute("password", st.getPassword());
				result.put("status","success");
			}
		}else{
			result.put("status","fail");
	    }
		return result;
	}
	
	@RequestMapping(value = "/updatePassword.do",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> updatePassword(String id,String password,String type) throws Exception{
		Map<String, Object> map = new HashMap<String,Object>();
		Map<String, String> result = new HashMap<String,String>();
		int userType = -1;
		if(type!=null&&!"".equals(type)){
			userType = Integer.parseInt(type);
		}
		if(userType == 0){
			try {
				map.put("id", Integer.parseInt(id));
				map.put("password", password);
				dao.updateSystemPassword(map);
				result.put("status", "success");
			} catch (Exception e) {
				e.printStackTrace();
				result.put("status", "fail");
			}
		}else if(userType == 1){
			try {
				map.put("id", Integer.parseInt(id));
				map.put("password", password);
				dao.updateTeaPassword(map);
				result.put("status", "success");
			} catch (Exception e) {
				e.printStackTrace();
				result.put("status","fail");
			}
		}else if(userType == 2){
			try {
				map.put("id", id);
				map.put("password", password);
				dao.updateSystemPassword(map);
				result.put("status", "success");
			} catch (Exception e) {
				e.printStackTrace();
				result.put("status", "fail");
			}
			
		}else{
			result.put("status","fail");
		}
		return result;
		
	}
}
