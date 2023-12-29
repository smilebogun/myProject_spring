package kr.ezen.pwEncoder.test;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class InterceptorDemo1 implements HandlerInterceptor {
	
	// preHandle -- boolean 리턴이 있네?
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		System.out.println("InterceptorDemo1 preHandle() 호출~~");
		
		return true;
	}
	
	// postHandle
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

		System.out.println("InterceptorDemo1 postHandle() 호출~~");
	}
	
	// afterCompletion
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {

		System.out.println("InterceptorDemo1 afterCompletion() 호출~~");
	}
}
