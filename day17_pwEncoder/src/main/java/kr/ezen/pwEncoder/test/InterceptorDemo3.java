package kr.ezen.pwEncoder.test;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class InterceptorDemo3 extends HandlerInterceptorAdapter {
	
	// preHandle -- boolean 리턴이 있네?
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		System.out.println("InterceptorDemo3 preHandle() 호출~~");
		
		return true;
	}
	
	// postHandle
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

		System.out.println("InterceptorDemo3 postHandle() 호출~~");
	}
	
	// afterCompletion
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {

		System.out.println("InterceptorDemo3 afterCompletion() 호출~~");
	}
}
