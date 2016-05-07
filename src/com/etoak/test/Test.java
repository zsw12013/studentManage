package com.etoak.test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.etoak.util.Sender;

public class Test {
	public static void main(String[] args) throws Exception {
		/*List list = new ArrayList();
		list.add("a");
		list.add("b");
		 for (Iterator iter = list.iterator(); iter.hasNext();) {
			   String str = (String)iter.next();
			   System.out.println(str);
			  }
		 */
		/*String a = "20121020202,20121112045,";
		String b[] = a.split(","); 
		for(int i=0;i<b.length;i++){
			System.out.println(b[i]);
		}*/
		 //发送邮件
		 Map map = new HashMap();
			map.put("from","18366183724@163.com");
			map.put("to","1197319946@qq.com");
			map.put("cc", "");
			map.put("content", "这是邮件内容");
			map.put("subject","这是主题");
			Sender sd = new Sender();
			sd.send(map);
	}
}
