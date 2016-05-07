package com.etoak.entity;

import org.springframework.web.multipart.MultipartFile;
/**
 * 文件实体类
 * 从excel导入学生时上传文件
 * @author 邓晓
 */
public class ImportFile {
	private MultipartFile myfile;
	public MultipartFile getMyfile() {
		return myfile;
	}
	public void setMyfile(MultipartFile myfile) {
		this.myfile = myfile;
	}
}
