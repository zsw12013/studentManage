package com.etoak.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.etoak.entity.Student;
/**
 * 读excel工具类，这里只用作导入学生,按模板固定列导入
 * 没有完成通用的封装
 * excel数据须与模板一致
 * @author 邓晓
 */
public class Read {
	/**
	 * 对外提供读取excel 的方法
	 * */
	public static List<Student> readExcel(File file) throws IOException {
		String fileName = file.getName();
		String extension = fileName.lastIndexOf(".") == -1 ? "" : fileName
				.substring(fileName.lastIndexOf(".") + 1);
		if ("xls".equals(extension)) {
			return read2003Excel(file);
		} else if ("xlsx".equals(extension)) {
			return read2007Excel(file);
		} else {
			throw new IOException("不支持的文件类型");
		}
	}

	private static List<Student> read2003Excel(File file)
			throws IOException {
		List<Student> list = new LinkedList<Student>();
		Student stu = new Student();
		HSSFWorkbook hwb = new HSSFWorkbook(new FileInputStream(file));
		HSSFSheet sheet = hwb.getSheetAt(0);
		Object value = null;
		HSSFRow row = null;
		HSSFCell cell = null;
		int counter = 0;
		for (int i = 1; i < sheet
				.getPhysicalNumberOfRows()+1; i++) {
			row = sheet.getRow(i);
			row.getCell(0).setCellType(Cell.CELL_TYPE_STRING);
			row.getCell(1).setCellType(Cell.CELL_TYPE_STRING);
			//row.getCell(2).setCellType(Cell.CELL_TYPE_STRING);
			row.getCell(3).setCellType(Cell.CELL_TYPE_STRING);
			row.getCell(4).setCellType(Cell.CELL_TYPE_STRING);
			row.getCell(5).setCellType(Cell.CELL_TYPE_STRING);
			row.getCell(6).setCellType(Cell.CELL_TYPE_STRING);
			stu.setId(row.getCell(0).getStringCellValue());
			stu.setName(row.getCell(1).getStringCellValue());
			//stu.setAge(Integer.parseInt(row.getCell(2).getStringCellValue()));
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");  
		//	Date date = cell.getDateCellValue();  
        //    result = sdf.format(date);  
			//对日期列birth的读取：
			if(DateUtil.isCellDateFormatted(row.getCell(2))){// 判断单元格是否属于日期格式  
			        Date date2 = row.getCell(2).getDateCellValue();
			        SimpleDateFormat dff = new SimpleDateFormat("yyyy-MM-dd"); 
			        String date1 = dff.format(date2);   //日期转化
			        stu.setBirth(date1);
			}
			//stu.setBirth(row.getCell(3).getDateCellValue().toString());
			stu.setSex(row.getCell(3).getStringCellValue());
			stu.setAddress(row.getCell(4).getStringCellValue());
			stu.setTel(row.getCell(5).getStringCellValue());
			stu.setEmail(row.getCell(6).getStringCellValue());
			list.add(stu);
		}
		return list;
	}

	private static List<Student> read2007Excel(File file)
			throws IOException {
		List<Student> list = new LinkedList<Student>();
		
		// 构造 XSSFWorkbook 对象，strPath 传入文件路径
		XSSFWorkbook xwb = new XSSFWorkbook(new FileInputStream(file));
		// 读取第一章表格内容
		XSSFSheet sheet = xwb.getSheetAt(0);
		Object value = null;
		XSSFRow row = null;
		XSSFCell cell = null;
		//
		for (int i = sheet.getFirstRowNum()+1; i < sheet
				.getPhysicalNumberOfRows(); i++) {
			Student stu = new Student();
			row = sheet.getRow(i);
			row.getCell(0).setCellType(Cell.CELL_TYPE_STRING);
			row.getCell(1).setCellType(Cell.CELL_TYPE_STRING);
			//row.getCell(2).setCellType(Cell.CELL_TYPE_STRING);
			row.getCell(3).setCellType(Cell.CELL_TYPE_STRING);
			row.getCell(4).setCellType(Cell.CELL_TYPE_STRING);
			row.getCell(5).setCellType(Cell.CELL_TYPE_STRING);
			row.getCell(6).setCellType(Cell.CELL_TYPE_STRING);
			stu.setId(row.getCell(0).getStringCellValue());
			stu.setName(row.getCell(1).getStringCellValue());
			//stu.setAge(Integer.parseInt(row.getCell(2).getStringCellValue()));
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");  
		//	Date date = cell.getDateCellValue();  
        //    result = sdf.format(date);  
			//对日期列birth的读取：
			if(DateUtil.isCellDateFormatted(row.getCell(2))){// 判断单元格是否属于日期格式  
			        Date date2 = row.getCell(2).getDateCellValue();
			        SimpleDateFormat dff = new SimpleDateFormat("yyyy-MM-dd"); 
			        String date1 = dff.format(date2);   //日期转化
			        stu.setBirth(date1);
			}
			//stu.setBirth(row.getCell(3).getDateCellValue().toString());
			stu.setSex(row.getCell(3).getStringCellValue());
			stu.setAddress(row.getCell(4).getStringCellValue());
			stu.setTel(row.getCell(5).getStringCellValue());
			stu.setEmail(row.getCell(6).getStringCellValue());
			list.add(stu);
		}
		//System.out.println(list);
		return list;
	}

	public static void main(String[] args) {
		try {
			readExcel(new File("C:\\1.xlsx"));
			// readExcel(new File("D:\\test.xls"));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
