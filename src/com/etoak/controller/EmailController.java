package com.etoak.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.etoak.util.Sender;

@Controller
public class EmailController {
	@RequestMapping(value = "/send_email.do",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> login(String email,String toemail,String content,String subject,String password,HttpServletRequest request) throws Exception{
		Map<String, String> map = new HashMap<String,String>();
		Map<String, String> result = new HashMap<String,String>();
		try {
			map.put("from",email);
			map.put("to",toemail);
			map.put("cc", "");
			map.put("content", content);
			map.put("subject",subject);
			Sender sd = new Sender();
			sd.setUsername(email);
			sd.setPassword(password);
			sd.send(map);
			result.put("status", "success");
		} catch (Exception e) {
			result.put("status","fail");
		}
		return result;
	}
}
