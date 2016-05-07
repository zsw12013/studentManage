package com.etoak.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.DispatcherServlet;
/**
 * spring防止乱码工具类
 * @author 邓晓
 */
public class MyDispatcherServlet extends DispatcherServlet {
    @Override
    protected void doService(HttpServletRequest request, 
            HttpServletResponse response)
            throws Exception {
        // TODO Auto-generated method stub

        request.setCharacterEncoding("utf-8");

        super.doService(request, response);
    }
}
