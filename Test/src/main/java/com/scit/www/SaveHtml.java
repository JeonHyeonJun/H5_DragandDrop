package com.scit.www;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;

public class SaveHtml {
	
	public static void savehtml(String html){
		ObjectOutputStream out = null;
//		FileOutputStream out = null;
		
		System.out.println(html);
			try {
				out = new ObjectOutputStream(new FileOutputStream("test.html"));
				out.writeObject(html);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				try {
					out.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
	}
}
