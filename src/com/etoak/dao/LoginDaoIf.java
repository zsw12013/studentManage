package com.etoak.dao;
import java.util.Map;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import com.etoak.entity.Student;
import com.etoak.entity.SystemUser;
import com.etoak.entity.Teacher;

@Repository
public interface LoginDaoIf {
	
	
	@Select("select * from student where id=#{id} and password=#{password}")
	public Student checkStudent(Map<String,String> map);  
	
	@Select("select * from teacher where workId=#{id} and password=#{password}")
	public Teacher checkTeacher(Map<String,String> map);  
	
	@Select("select * from system_user where workId=#{id} and password=#{password}")
	public SystemUser checkSystemUser(Map<String,String> map);  
	
	
	
	@Update("update student set password=#{password} where id=#{id}")
	public int updateStuPassword(Map<String,Object> map);  
	
	@Update("update teacher set password=#{password} where id=#{id}")
	public int updateTeaPassword(Map<String,Object> map);  
	
	@Update("update system_user set password=#{password} where id=#{id}")
	public int updateSystemPassword(Map<String,Object> map);  
} 
