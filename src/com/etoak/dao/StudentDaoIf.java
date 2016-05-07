package com.etoak.dao;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import com.etoak.entity.Student;
import com.etoak.page.SearchPageUtil;

@Repository
public interface StudentDaoIf {
	
	@Insert("insert into student values(#{id},#{name},#{birth},#{sex}," +
			"#{address},#{tel},#{email},#{classid},#{userType},'','','',#{password})")
	public int addStudent(Student stu);
	
	@Delete("delete from student where id=#{id}")
	public int delStudentById(String id);
	
	@Update("update student t set name=#{name},birth=#{birth},address=#{address}," +
			"tel=#{tel},email=#{email},sex=#{sex},favorite=#{favorite},t.describe=#{describe},reward=#{reward} where id=#{id}")
	public int updateStudent(Student stu);

	@Select("select c.text as classname,TIMESTAMPDIFF(YEAR,s.birth,DATE_FORMAT(NOW(),'%Y-%m-%d')) as age,s.id ,s.name," +
			"s.birth,s.sex,s.address,s.tel,s.email,s.classid from student s,classes c where s.classid=c.id <if test=\"param !=null \">and name = #{param} </if> ")
	public List<Student> selectAllStudents(SearchPageUtil searchPageUtil,@Param("param")String param);  
	//数据库查出来的字段名和bean的属性名相同，则不需要results
	
	@Select("select count(*) from student")
	public int studentCount();
	
	@Select("select c.text as classname,TIMESTAMPDIFF(YEAR,s.birth,DATE_FORMAT(NOW(),'%Y-%m-%d')) as age," +
			"s.id ,s.name,s.birth,s.sex,s.address,s.tel,s.email,s.classid " +
			"from student s,classes c where s.classid=c.id and classid=#{stu.classid}")
	public List<Student> selectStudentByClassId(SearchPageUtil searchPageUtil,@Param("stu")Student stu);
	
	//导出excel查询某个班级学生信息  和上个不同的是这个不需要分页
	@Select("select c.text as classname,TIMESTAMPDIFF(YEAR,s.birth,DATE_FORMAT(NOW(),'%Y-%m-%d')) as age," +
			"s.id ,s.name,s.birth,s.sex,s.address,s.tel,s.email,s.classid " +
			"from student s,classes c where s.classid=c.id and classid=#{id}")
	public List<Student> selectClass(String id);
	
	//批量插入学生---配置文件
	public int batchInsert(List<Student> students);
	
	//批量删除学生---配置文件
	public int batchDelete(List students);
	
	@Select("select * from student where id=#{id}")
	public Student getStudent(String id);  
} 
