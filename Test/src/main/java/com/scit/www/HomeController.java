package com.scit.www;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;



/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	final String uploadPath = "/upload"; 
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	@RequestMapping(value = "videoTest", method = RequestMethod.GET)
	public String videoTest() {
		return "videoTest";
	}
	@RequestMapping(value = "imgResizeTest", method = RequestMethod.GET)
	public String imgResizeTest() {
		return "imgResizeTest";
	}
	@RequestMapping(value = "fileTest", method = RequestMethod.GET)
	public String fileTest() {
		return "fileIcon";
	}
	@RequestMapping(value = "tableTest", method = RequestMethod.GET)
	public String tableTest() {
		return "tableTest";
	}
	@RequestMapping(value = "wigetTest", method = RequestMethod.GET)
	public String wigetTest() {
		return "wigetTest";
	}
	@RequestMapping(value = "wigetTest2", method = RequestMethod.GET)
	public String wigetTest2() {
		return "jquerydnd";
	}
	@RequestMapping(value = "jspFileTest", method = RequestMethod.GET)
	public String jspFileTest() {
		return "jspFileTest";
	}
	@RequestMapping(value = "angularTest", method = RequestMethod.GET)
	public String angularTest() {
		return "angularTest";
	}
	@RequestMapping(value = "agDragTest", method = RequestMethod.GET)
	public String agDragTest() {
		return "agDragTest";
	}
	@RequestMapping(value = "agDndTest", method = RequestMethod.GET)
	public String agD() {
		return "agDndTest";
	}
	@RequestMapping(value = "agsimple", method = RequestMethod.GET)
	public String agSimple() {
		return "agSimple";
	}
	@RequestMapping(value = "edTest", method = RequestMethod.GET)
	public String edTest() {
		return "editText";
	}
	@RequestMapping(value="uploadfile", method=RequestMethod.POST)
	public String writeBoard(MultipartFile upload, Model model){
		String result = "";
		HashMap<String, Object> params = new HashMap<String, Object>();
		if(!upload.isEmpty()){
			String savedfile = FileService.saveFile(upload, uploadPath);
			String originfile = upload.getOriginalFilename();
			result = "success";
			params.put("savefile", savedfile);
			params.put("originfile", originfile);
			params.put("result", result);
			model.addAttribute("params", params);
			
		}
		return "fileIcon";
	}
	
	
	@RequestMapping(value="download", method=RequestMethod.GET)
	public void fileDownload(String originfile, String savefile, HttpServletResponse response){
		
		//원래 파일명 response Header에 인코딩해서 등록
		if(originfile == null)
			return;
		
		try{
			//필수! 복붙해서 사용.
			response.setHeader("Content-Disposition", 
					"attachment;filename="+URLEncoder.encode(originfile, "UTF-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		//outputstream을 연결
		//저장된 파일 경로
		String fullPath = uploadPath + "/" + savefile;
		//서버의 파일을 읽을 입력 스트림과 클라이언트에게 전달할 출력스트림
		FileInputStream fis = null;
		ServletOutputStream sos = null;
		
		try{
			fis = new FileInputStream(fullPath);
			sos = response.getOutputStream();
			
			FileCopyUtils.copy(fis, sos);
			
			fis.close();
			sos.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
}
