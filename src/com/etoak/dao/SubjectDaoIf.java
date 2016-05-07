package com.etoak.dao;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import com.etoak.entity.Subject;
import com.etoak.entity.Term;

@Repository
public interface SubjectDaoIf {
	
	@Insert("insert into subject values(#{id},#{classid},#{termid},#{subject},#{teacher},#{classroom},#{remark})")
	public int addSubject(Subject sub);
	
	@Delete("delete from subject where id=#{id}")
	public int delSubjectById(int id);
	
	@Update("update subject set subject=#{subject},teacher=#{teacher},classroom=#{classroom},remark=#{remark} where id=#{id}")
	public int updateSubjectById(Subject sub);
	
	@Select("select * from subject where termid=#{termid} and classid=#{classid}")
	public List<Subject> selectSubjects(Subject sub);  
	
	@Select("select * from term")
	public List<Term> selectTerms();
	
	
} 
