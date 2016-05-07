package com.etoak.dao;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import com.etoak.entity.Evaluate;
import com.etoak.entity.Teacher;
import com.etoak.page.SearchPageUtil;

@Repository
public interface TeacherDaoIf {
	
	@Insert("insert into teacher(name,email) values(#{name},#{email})")
	public int addTeacher(Teacher tea);
	
	@Delete("delete from teacher where id=#{id}")
	public int delTeacherById(int id);
	
	@Update("update teacher set name=#{name},email=#{email} where id=#{id}")
	public int updateTeacher(Teacher tea);
	
	@Update("update teacher set zanNum=zanNum+1 where id=#{id}")
	public int updateTeaZan(int id);
	
	@Update("update teacher set password=#{password} where id=#{id}")
	public int updatePassword(int id);

	@Select("select * from teacher where id=#{id}")
	public Teacher selectTeacher(int id);
	
	@Select("select * from teacher")
	public List<Teacher> selectAllTeachers(SearchPageUtil searchPageUtil);  
	//数据库查出来的字段名和bean的属性名相同，则不需要results
	
	@Select("select count(*) from teacher")
	public int teacherCount();
	
	@Select("select * from evaluate where t_id=#{id} and content is not null")
	public List<Evaluate> selectEvaluateById(int id);
	
	@Select("select count(*) from evaluate")
	public int evaluateCount();
	
	@Select("select t.name,e.id,e.content from teacher t,evaluate e where t.id=e.t_id and e.content is not null ")
	public List<Evaluate> selectAllEvaluates(SearchPageUtil searchPageUtil);
	
	@Delete("delete from evaluate where id=#{id}")
	public int delEvaluateById(int id);
	
	//添加评价
	@Insert("insert into evaluate(t_id,s_id,content) values(#{t_id},#{s_id},#{content})")
	public int addEvaluate(Evaluate e);
	
	@Update("update evaluate set content=#{content} where id=#{id}")
	public int updateEvaluate(Evaluate e);
	
	@Select("select * from evaluate where t_id=#{t_id} and s_id=#{s_id}")
	public Evaluate getEvaluate(Evaluate e);
	//点赞
	@Insert("insert into evaluate(t_id,s_id,zan) values(#{t_id},#{s_id},1)")
	public int addZan(Evaluate e);
	
	@Update("update evaluate set zan=1 where id=#{id}")
	public int updateZan(Evaluate e);
	
	@Select("select * from evaluate where t_id=#{t_id} and s_id=#{s_id}")
	public Evaluate getZan(Evaluate e);
	
} 
