package com.etoak.util;

import java.util.Date;
import java.util.Map;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class Sender {
	//填写 邮箱的用户名 / 密码 这个可以配置在一个properties 文件中
	private String username ;
	private String password ;
	
	//这里可以放一个对象进来不用非用map
	public void send(Map map)throws Exception{
		/*
		 * 创建Properties对象
		 * 设置连接的邮件服务地址
		 * 开启身份验证
		 */
		Properties props = new Properties();
		//这个是邮箱服务 smtp.163.com  qq 的就是smtp.qq.com
		props.put("mail.smtp.host", "smtp.qq.com");
		//开启验证
		props.put("mail.smtp.auth", "true");
		/*
		 * 从 ProPerties中创建一个会话对象 ,连接邮件服务器
		 * getDefaultInstance(1,2)
		 * 1Properties
		 * 2身份验证对象Authenticator
		 */
		Session session = Session.getDefaultInstance(props,new Authenticator(){
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				// TODO Auto-generated method stub
				//这个事验证用户名和密码
				return new PasswordAuthentication(username, password);
			}
		});
		/*
		 * 定义邮件内容对象 Message  将session 放入
		 */
		Message msg = new MimeMessage(session);
		//定义发送人
		Address from = new InternetAddress((String)map.get("from"));
		msg.setFrom(from);
		//定义收件人
		Address to = new InternetAddress((String)map.get("to"));
		msg.setRecipient(Message.RecipientType.TO,to);
		/*Address[] tos = new Address[3];
		msg.setRecipients(Message.RecipientType.TO, tos);*/
		//定义抄送人  这里如果是多个的话   需要一个Address 数组
		//Address cc = new InternetAddress((String)map.get("cc"));
		//msg.setRecipient(Message.RecipientType.CC,cc);
		//设置主题
		msg.setSubject((String)map.get("subject"));
		/*
		 * 添加邮件内容
		 * setContent
		 */
		msg.setContent((String)map.get("content"),"text/plain;charset=utf-8");
		//发送时间
		msg.setSentDate(new Date());
		//保存消息
		msg.saveChanges();
		//发送消息
		Transport.send(msg);
	}
	
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
}
