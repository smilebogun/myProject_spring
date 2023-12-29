package kr.ezen.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class InterceptorTest {
	
	@GetMapping("/test1")
	public String test1() {
		System.out.println("test1 Controller 호출~~");
		return "interceptor/test1";
	}
	
	@GetMapping("/test2")
	public String test2() {
		System.out.println("test2 Controller 호출~~");
		return "interceptor/test2";
	}
	
	//@GetMapping("/test3")
	@GetMapping("/bbs/test3")
	public String test3() {
		System.out.println("test3 Controller 호출~~");
		return "interceptor/test3";
	}
	
	@GetMapping("/bbs/test4")
	public String test4() {
		System.out.println("test4 Controller 호출~~");
		return "interceptor/test4";
	}
}
