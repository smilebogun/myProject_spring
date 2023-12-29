package kr.ezen.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
public class FileController {

	// 업로드 폼
	@RequestMapping("/fileUpload.do")
	public String fileUpload() {
		return "member/fileUpload";
	}
	
	// 업로드OK -> 업로드 폼
	@RequestMapping("/fileUploadOk.do")
	public String fileUploadOk(MultipartHttpServletRequest mhr, 
			HttpServletRequest request, Model model) throws IOException {
		// 파일 저장할 경로
		String repository = "resources/fileRepository";
		
		// 서버의 물리경로 얻어오기 pom.xml에서 변경해줘야함
//		<!-- Servlet -->
//		<dependency>
//		<groupId>javax.servlet</groupId>
//		<artifactId>javax.servlet-api</artifactId>
//		<version>3.1.0</version>
//		<scope>provided</scope>
//		</dependency>
		
		// 파일을 저장할 실제 서버의 물리경로 얻어오기
		// OS에 따라 \\(윈도우), /(리눅스)
		String savePath = request.getServletContext().getRealPath("")+File.separator+repository;
		System.out.println(savePath);
		
////// 불러온 파일들을 모델로 바인딩해서 맵에 저장 이후 fileUploadResult에 출력
Map map = new HashMap();
		
		// 1. 넘길 정보들을 얻어오기 
		// MultipartHttpServletRequest mhr은 일반 텍스트, 바이너리 파일 정보를 모두 얻어 올 수 있는 객체.
		// 뷰딴 인풋의 name 속성의 값인 id와 name = 파라미터값을 가져옴
		Enumeration<String> enu = mhr.getParameterNames();
		// Enumeration 객체 사용
		
		while(enu.hasMoreElements()) {
			// 뷰딴 인풋의 name 속성의 값인 id와 name을 가져오기
			String paramName = enu.nextElement();
			// 해당 파라미터명의 값, input의 value값 (사용자가 입력한 값)
			String paramValue = mhr.getParameter(paramName);
								// id, name : test, 홍길동
			System.out.println(paramName + " : " + paramValue);
////// 불러온 파일들을 모델로 바인딩해서 맵에 저장 이후 fileUploadResult에 출력			
map.put(paramName, paramValue);
		}
		
		// 2. 첨부 파일정보 얻어오기 Iterator 객체사용
		Iterator<String> iter = mhr.getFileNames();
////// 불러온 이미지 어레이리스트로 바인딩해서 어레이리스트로 저장 이후 fileUploadResult에 출력
List<String> fileList = new ArrayList<String>();
		
		while(iter.hasNext()) {
			// input의 name값을 가져오기
			String fileParamName = iter.next();
			System.out.println("fileParamName : "+ fileParamName);
			
			// MultipartFile : 파일정보를 갖고 있는 객체
			MultipartFile mFile = mhr.getFile(fileParamName);
			// 첨부된 파일명
			String originName = mFile.getOriginalFilename();
			System.out.println("originName : "+ originName);
			
			// ~ \day05_fileUpDown\\resources/fileRepository/file1
			// 물리경로\\해당파일이름 을 file 주소로 넣어놓기
			File file = new File(savePath+"\\"+fileParamName);
			
			if(mFile.getSize() != 0) { // 사이즈가 0이 아니면 업로드 된경우 (폴더가 존재한 경우)
				if(!file.exists()) { // 폴더가 존재하지만 파일이 존재하지 않으면
					//file.createNewFile();
					if(file.getParentFile().mkdir()) {	// file1의 부모경로로 가서 폴더를 만들고
						file.createNewFile(); // throws 예외처리 진행, 임시파일 생성 // 파일을 만든다
					} // if3
				}	// if2
				
				File uploadFile = new File(savePath+"\\"+originName);
				
				// 중복시 파일명 대체
				if(uploadFile.exists()) {	// 시간을 기준으로 다시 재저장
					originName = System.currentTimeMillis()+"_"+originName;
					uploadFile = new File(savePath+"\\"+originName);
				}
				// 실제 파일 업로드
				mFile.transferTo(uploadFile);
// 파일명을 list에 추가
//////불러온 이미지 어레이리스트로 바인딩해서 어레이리스트로 저장 이후 fileUploadResult에 출력
fileList.add(originName);
				
			}	// if1
		}
		
// 파일명을 저장한 리스트를 map에 추가
////// 불러온 파일들을 모델로 바인딩해서 맵에 저장 이후 fileUploadResult에 출력	
map.put("fileList", fileList);
//////불러온 이미지 어레이리스트로 바인딩해서 어레이리스트로 저장 이후 fileUploadResult에 출력
model.addAttribute("map", map);
		
		return "member/fileUploadResult";
	} // fileUploadOk
	
	// 업로드폼 -> 다운로드OK
	@RequestMapping("/fileDownload.do") 
	// request, response 은 클라이언트 정보를 모두 가지고 있음, DispatcherServlet 에게 넘기고 받음
	public void fileDownload(@RequestParam("fName") String fName,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 파일 저장된 경로
		String repository = "resources/fileRepository";
		
		// 파일을 저장된 실제 서버의 물리경로 얻어오기
		// OS에 따라 \\(윈도우), /(리눅스)
		String savePath = request.getServletContext().getRealPath("")+File.separator+repository;
		System.out.println(savePath);
		
		// ~ \day05_fileUpDown\\resources/fileRepository/file1
		// 물리경로\\해당파일이름 을 file 주소로 넣어놓기
		File file = new File(savePath+"\\"+fName);
		
		// 다운로드를 위한 준비과정
	      response.setContentLength((int)file.length()); // 브라우저에게 파일크기를 알려줌
	      response.setContentType("application/x-msdownload;charset=utf-8");
	      response.setHeader("Content-Disposition", "attachment;fileName="+fName+";");
	      response.setHeader("Content-Transfer-Encoding","binary");
	      
	    // 다운로드처리 -> 서버를 통하는 통로가 필요함
	      // 요청한 파일(서버)에 빨대꼽고 파일가져오기
	      FileInputStream fis = new FileInputStream(file);
	      // 요청한 클라이언트에 빨대꼽고 파일보내기
	      OutputStream out = response.getOutputStream();
	      // FileOutputStream out2 = response.getOutputStream(); 
	      // getOutputStream() 은 OutputStream에서만 리턴을 해줌
	      // FileOutputStream 은 getOutputStream 사용불가 (부모, 자식관계)
	      // extends 관계
	      
	      // 버퍼로 보냄, 1024 바이트씩 읽어오겠다
	      byte[] buffer = new byte[1024];
	      while(true) {	
	    	  // n(1024)은 읽어드린 데이터의 길이
	    	  int n = fis.read(buffer); // 서버의 통로에서 버퍼의 크기만큼 읽어오겠다	
	    	  if( n == -1 ) {	// 파일의 끝(EOF : End Of File, 파일을 다 읽어오면 -1을 리턴)
	    		  break;
	    	  }
	    	  // 통로에서 버퍼의 크기만 큼 read 읽어온걸, out 클라이언트에 보내겠다.
	    	  // write(byte[] buffer, int off, int length - 1024)
	    	  // buffer[off] 부터 length개의 바이트를 출력 스트림에 보냄
	    	  out.write(buffer, 0, n);
	      }
	      
	    // 통로는 반드시 닫아야 함 (메모리문제 및 결과값문제)
		fis.close();
		out.close();
	}
	
} // FileController
