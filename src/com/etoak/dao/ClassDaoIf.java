package com.etoak.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.mapping.StatementType;
import org.springframework.stereotype.Repository;

import com.etoak.entity.Classes;

@Repository
public interface ClassDaoIf {

	@Select("select * from classes where pid=#{id} and status=1")
	@Results({
		@Result(column = "id" , property = "id"),
		@Result(column = "text" , property = "text"),
		@Result(column = "pid" , property = "pid"),
	})
	public List<Classes> showClasses(String id);                      //显示树
	

	@Select("call addnode(#{pid},#{text})")
	@Options(statementType= StatementType.CALLABLE )
	public int addNode(Classes cls);
	
	@Update("update classes set status=0 where id=#{id}")
	public int disabledById(String id);                                 //停用节点，把status改为0
	
	@Update("update classes set text=#{text} where id=#{id}")
	public int updateNode(Classes cls);                              //更新节点名称

	@Select("select * from classes where pid=#{id}")
	public List<Classes> showAllClasses(String id);

	@Update("update classes set status=1 where id=#{id}")           
	public int openById(String id);									//启用节点
}
