package com.etoak.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.hssf.util.Region;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.etoak.entity.ImportFile;
import com.etoak.entity.Student;
import com.etoak.page.Page;
import com.etoak.service.StudentService;
import com.etoak.util.Read;
import com.etoak.util.UUIDGenerator;

/**
 * 学生管理
 * 
 * @author 邓晓
 */
@Controller
public class StudentController {

	private Page page;
	@Autowired
	private Student stu;
	@Autowired
	private StudentService dao;
	public static final String FILE_SEPARATOR = System.getProperties()
			.getProperty("file.separator"); // 导excel用


	/**
	 * 添加学生
	 * 
	 * @param stu
	 * @return
	 * @throws Exception
	 *             这种写法返回map会自动封装成json 要写value和method 不然的话就要自己写json返回
	 */
	@RequestMapping(value = "/add_stu.do", method = RequestMethod.POST)
	@ResponseBody
	public Map add(Student stu) throws Exception {
		Map map = new HashMap();
		stu.setPassword(stu.getId()); // 初始密码为学号
		stu.setUserType(2);
		int i = dao.addStudent(stu);
		if (i == 0) {
			map.put("status", "fail");
		} else {
			map.put("status", "success");
		}
		return map;
	}

	/**
	 * 更新学生
	 * 
	 * @param stu
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/update_stu.do", method = RequestMethod.POST)
	@ResponseBody
	public Map update(Student stu) throws Exception {
		Map map = new HashMap();
		int i = dao.updateStudent(stu);
		if (i == 0) {
			map.put("status", "fail");
		} else {
			map.put("status", "success");
		}
		return map;
	}

	/**
	 * 删除学生
	 * 
	 * @param stu
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/del_stu.do", method = RequestMethod.POST)
	@ResponseBody
	public Map delete(Student stu) throws Exception {
		Map map = new HashMap();
		int i = dao.delStudentById(stu.getId());
		if (i == 0) {
			map.put("status", "fail");
		} else {
			map.put("status", "success");
		}
		return map;
	}
	
	/**
	 * 批量删除学生
	 * 
	 * @param stu
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/del_many_stu.do")
	@ResponseBody
	public Map deleteMany(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String ids = request.getParameter("ids");
		String a[] = ids.split(","); 
		List list = new ArrayList();
		for(int i=0;i<a.length;i++){
			list.add(a[i]);
		}
		Map map = new HashMap();
		int i = dao.batchDelete(list);
		if (i == 0) {
			map.put("status", "fail");
		} else {
			map.put("status", "success");
		}
		return map;
	}

	/**
	 * 所有学生信息
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/show_stu.do")
	@ResponseBody
	public Map<String,Object> showStudents(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		int pageIndex = Integer.parseInt(request.getParameter("page"));
		int total = dao.studentCount();
		int pageSize = Integer.parseInt(request.getParameter("rows"));
		page = new Page(pageIndex, pageSize, total);
		String param = request.getParameter("param");
		Map<String,Object> map = new HashMap<String,Object>();
		List<Student> students = null;
		students = dao.selectAllStudents(stu, page,param);
		map.put("rows", students);
		map.put("total", total);
		return map;
	}
	/**
	 * 
	 * @Title  getStudentMsg 
	 * @Description  TODO(显示个人信息) 
	 * @date  2016-1-1 下午2:05:56
	 * @author  Administrator
	 * @modifier  Administrator
	 * @modifydate  2016-1-1 下午2:05:56
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getStudentMsg.do")
	@ResponseBody
	public JSONObject getStudentMsg(String id, HttpServletRequest request) throws Exception {
		JSONObject jo = new JSONObject();
		Student stu = dao.getStudent(id);
		jo.put("student", stu);
		return jo;
	}

	/**
	 * 列表显示某一班级学生信息
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/show_choose_stu.do")
	@ResponseBody
	public Map showChooseStu(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String classid = request.getParameter("id");
		stu.setClassid(classid);
		int pageIndex = Integer.parseInt(request.getParameter("page"));
		int total = dao.studentCount();
		int pageSize = Integer.parseInt(request.getParameter("rows"));
		page = new Page(pageIndex, pageSize, total);
		Map map = new HashMap();
		List<Student> students = dao.selectStudentByClassId(stu, page);
		map.put("rows", students);
		map.put("total", total);
		// System.out.println(map);
		return map;
	}

	/**
	 * 批量导入（先上传）
	 * 
	 * @param stu
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/import_stu.do", method = RequestMethod.POST)
	@ResponseBody
	public Map importStu(ImportFile importfile, HttpServletRequest request)
			throws Exception {
		MultipartFile myfile = importfile.getMyfile();
		String classid = request.getParameter("classid");

		/**************** 上传开始 *******************/
		String filename = myfile.getOriginalFilename();
		String contentType = myfile.getContentType();
		long size = myfile.getSize();
		// 从上传文件中获取一个输入流
		InputStream is = myfile.getInputStream();
		// 定位到file目录 request.session.ServletContext.getRealPath("/file")
		String path = request.getSession().getServletContext()
				.getRealPath("/file");
		String newFilename = new UUIDGenerator().generate().toString()
				+ filename.substring(filename.lastIndexOf("."));
		File file = new File(path + "/" + newFilename);
		OutputStream os = new FileOutputStream(file);
		int len;
		byte[] data = new byte[1024];
		while ((len = is.read(data)) != -1)
			os.write(data, 0, len);
		is.close();
		os.close();
		/*************** 上传结束 ********************/

		List<Student> list = Read.readExcel(file); // 读excel
		for (Student stu : list) {
			stu.setClassid(classid);
			stu.setUserType(2);
		}
		//System.out.println(list);
		Map map = new HashMap();

		int i = 0;
		i = dao.batchInsert(list); // 添加的异常处理！！！
		if (i == 0) {
			map.put("status", "fail");
		} else {
			map.put("status", "success");
		}
		return map;
	}

	/**
	 * 
	 * @Title  output 
	 * @Description  TODO(导出简历) 
	 * @date  2016-1-2 下午4:18:08
	 * @author  Administrator
	 * @modifier  Administrator
	 * @modifydate  2016-1-2 下午4:18:08
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/output.do")
	@ResponseBody
	public Map output(String id,HttpServletRequest request) throws Exception {
		Student stu = dao.getStudent(id);
		
		return null;
	}
	/**
	 * 导出学生信息到excel中，不需要exccel模板
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/export_stu.do")
	@ResponseBody
	public Map exportStu(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String classname = new String(request.getParameter("classname")
				.getBytes("ISO-8859-1"), "utf-8");
		String classid = request.getParameter("classid");
		String docsPath = request.getSession().getServletContext()
				.getRealPath("docs");
		String fileName = classname + "学生信息" + ".xls";
		String filePath = docsPath + FILE_SEPARATOR + fileName;
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet("学生表一");
		HSSFRow row = sheet.createRow(0);
		HSSFCell cell = row.createCell(0);
		row.setHeight((short) 400);
		cell.setCellType(HSSFCell.ENCODING_UTF_16);
		cell.setCellValue(new HSSFRichTextString(classname + "信息报表"));
		sheet.addMergedRegion(new Region(0, (short) 0, 0, (short) 8));
		// 单元格样式1 cellStyle
		HSSFCellStyle cellStyle = wb.createCellStyle();
		cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 指定单元格居中对齐
		cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 指定单元格垂直居中对齐
		cellStyle.setWrapText(true);// 指定单元格自动换行
		HSSFFont font = wb.createFont();
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		font.setFontName("宋体");
		font.setFontHeight((short) 300);
		cellStyle.setFont(font);
		cellStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		cellStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);

		cell.setCellStyle(cellStyle);
		// 单元格样式2
		HSSFCellStyle style = wb.createCellStyle();
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 指定单元格居中对齐
		style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 指定单元格垂直居中对齐
		style.setWrapText(true);// 指定单元格自动换行
		// 第四步，创建单元格，并设置值表头 设置表头居中
		HSSFRow row1 = sheet.createRow((int) 2);
		row1.setHeight((short) 400);
		HSSFCell cell1 = row1.createCell((short) 0);
		cell1.setCellValue("学号");
		cell1.setCellStyle(style);
		cell1 = row1.createCell((short) 1);
		cell1.setCellValue("姓名");
		cell1.setCellStyle(style);
		cell1 = row1.createCell((short) 2);
		cell1.setCellValue("年龄");
		cell1.setCellStyle(style);
		cell1 = row1.createCell((short) 3);
		cell1.setCellValue("生日");
		cell1.setCellStyle(style);
		cell1 = row1.createCell((short) 4);
		cell1.setCellValue("性别");
		cell1.setCellStyle(style);
		cell1 = row1.createCell((short) 5);
		cell1.setCellValue("籍贯");
		cell1.setCellStyle(style);
		cell1 = row1.createCell((short) 6);
		cell1.setCellValue("电话");
		cell1.setCellStyle(style);
		cell1 = row1.createCell((short) 7);
		cell1.setCellValue("邮箱");
		cell1.setCellStyle(style);
		HSSFRow row2 = sheet.createRow((int) 1);
		row2.setHeight((short) 400);
		HSSFCell cell2 = row2.createCell((short) 0);
		cell2.setCellValue("基础信息");
		cell2.setCellStyle(style);
		cell2 = row2.createCell((short) 8);
		cell2.setCellValue("总计");
		cell2.setCellStyle(style);

		sheet.setColumnWidth(0, 15 * 256); // 设置每列的宽度
		sheet.setColumnWidth(3, 15 * 256);
		sheet.setColumnWidth(5, 15 * 256);
		sheet.setColumnWidth(6, 15 * 256);
		sheet.setColumnWidth(7, 22 * 256);
		sheet.setColumnWidth(8, 15 * 256);
		// 合并第二行的第一列到底4列，此行占1行
		// 此行位置 从第几行 占几行 到第几行
		sheet.addMergedRegion(new Region(1, (short) 0, 1, (short) 7));
		sheet.addMergedRegion(new Region(1, (short) 8, 2, (short) 8));
		cell2.setCellStyle(style);
		List list;
		try {
			list = getStudent(classid);
			// System.out.println("有"+list.size()+"条记录");
			for (int i = 0; i < list.size(); i++) {
				row1 = sheet.createRow((int) i + 3);
				row1.setHeight((short) 300);
				Student stu = (Student) list.get(i);
				row1.createCell((short) 0).setCellValue(stu.getId());
				row1.createCell((short) 1).setCellValue(stu.getName());
				row1.createCell((short) 2).setCellValue(stu.getAge());
				row1.createCell((short) 3).setCellValue(stu.getBirth());
				row1.createCell((short) 4).setCellValue(stu.getSex());
				row1.createCell((short) 5).setCellValue(stu.getAddress());
				row1.createCell((short) 6).setCellValue(stu.getTel());
				row1.createCell((short) 7).setCellValue(stu.getEmail());
				row1.getCell((short) 0).setCellStyle(style);
				row1.getCell((short) 1).setCellStyle(style);
				row1.getCell((short) 2).setCellStyle(style);
				row1.getCell((short) 3).setCellStyle(style);
				row1.getCell((short) 4).setCellStyle(style);
				row1.getCell((short) 5).setCellStyle(style);
				row1.getCell((short) 6).setCellStyle(style);
				row1.getCell((short) 7).setCellStyle(style);
			}
			row1 = sheet.getRow((int) 3);
			row1.createCell((short) 8).setCellValue("共" + list.size() + "条记录");
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		try {
			OutputStream os = new FileOutputStream(filePath);
			wb.write(os);
			os.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		download(filePath, response);

		Map map = new HashMap();
		return map;
	}

	/**
	 * 获取一个班级的学生信息，准备填充到excel中
	 * 
	 * @return
	 * @throws Exception
	 */
	private List<Student> getStudent(String classid) throws Exception {
		List list = new ArrayList();
		list = dao.selectClass(classid);
		return list;
	}

	/**
	 * 下载excel(导出)
	 * 
	 * @param path
	 * @param response
	 */
	private void download(String path, HttpServletResponse response) {
		response.setCharacterEncoding("UTF-8");
		try {
			File file = new File(path);
			String filename = file.getName();
			InputStream fis = new BufferedInputStream(new FileInputStream(path));
			byte[] buffer = new byte[fis.available()];
			fis.read(buffer);
			fis.close();
			response.reset();
			response.addHeader("Content-Disposition", "attachment;filename="
					+ new String(filename.getBytes("gb2312"), "ISO8859-1"));
			response.addHeader("Content-Length", "" + file.length());
			OutputStream toClient = new BufferedOutputStream(
					response.getOutputStream());
			response.setContentType("application/vnd.ms-excel;charset=gb2312");
			toClient.write(buffer);
			toClient.flush();
			toClient.close();
		} catch (IOException ex) {
			ex.printStackTrace();
		}
	}
	/**
	 * 下载导入模板
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/download_templet.do")
    public void download(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String path = request.getSession().getServletContext().getRealPath("/docs");
        String filename = "导入模板.xls";
        File file = new File(path+"/"+filename);

        response.setContentType("multipart/form-data");
        response.addHeader("Content-Disposition", "attachment;filename="
				+ new String(filename.getBytes("gb2312"), "ISO8859-1"));
       // response.setHeader("content-Disposition", "attachment;filename=导入模版.xls");
        InputStream is = new FileInputStream(file);
        OutputStream os = response.getOutputStream();
        int len;
        byte[] data = new byte[1024];
        while((len=is.read(data))!=-1)
            os.write(data, 0, len);
        is.close();
        os.close();
    }
}
