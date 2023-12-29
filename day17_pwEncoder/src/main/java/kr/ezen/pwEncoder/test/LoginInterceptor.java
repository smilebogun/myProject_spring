package kr.ezen.pwEncoder.test;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class LoginInterceptor implements HandlerInterceptor {
	
	// preHandle -- boolean 리턴이 있네?
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		System.out.println("LoginInterceptor~~");
		
		HttpSession session = request.getSession();

		System.out.println(request.getRequestURL());	// http://localhost:8088/interceptor/memberList.do
		System.out.println(request.getQueryString()); // 얘 때문에 인코딩 해줘야 함 // bid=175&viewPage=1&searchType=&keyword=&cntPerPage=10
		// URL 인코딩 < == > 반대말은 URL디코딩(URLDecoder)
		// URL을 서버가 이해할 수 있는 표준 형식으로 변환하는 것
		// URLEncoder.encode(moveURL, "utf-8");
		String moveURL = URLEncoder.encode(request.getRequestURL() +"?"+ request.getQueryString(), "utf-8");

	    // StringBuilder 로도 사용할 수 있음
//      StringBuilder builder = new StringBuilder();
//      builder.append(request.getRequestURL());
//      builder.append("?");
//      builder.append(request.getQueryString());
//      String url = builder.toString();
//      String moveURL = URLEncoder.encode(url, "utf-8");

		if(session.getAttribute("loginDTO") == null) {		// 인터셉터 발생시, 무브url에다가 마지막 주소를 넘겨줌 ==> 로그인폼, 로그인폼OK로 넘겨줌
			//response.sendRedirect("memberLogin.do");	// sendRedirect은 Get방식
			response.sendRedirect("memberLogin.do?moveURL="+moveURL);	// sendRedirect은 Get방식
			return false; 						// return false는 인터셉터가 중지가 되는 것
		}
		
		return true;					// return true은 인터셉터가 계속 진행되는 것
	}
	
}
