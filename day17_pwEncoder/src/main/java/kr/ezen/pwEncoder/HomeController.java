package kr.ezen.pwEncoder;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired	// 암호화 테스트를위해서 root 추가한 pwEncoder에서 주입받음
	private BCryptPasswordEncoder pwEncoder;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
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
	
	// 암호화 테스트 "chiper = 암호"
	@RequestMapping("chiperTest")
	public void chiperTest() {
		String plainPw = "test1234";
		
		String encPw1 = pwEncoder.encode(plainPw); // test1234
		String encPw2 = pwEncoder.encode(plainPw); // test1234
		
		System.out.println("encPw1 :" + encPw1);	// 암호화로 서로 다르게 표현됌
		System.out.println("encPw2 :" + encPw2);	// 암호화로 서로 다르게 표현됌
		System.out.println("============================");
		
		String pw1 = "test1234";
		String pw2 = "abcd";
		
		System.out.println(pwEncoder.matches(pw1, encPw1));	// 매치 true // test1234 : test1234
		System.out.println(pwEncoder.matches(pw1, encPw2)); // 매치 true // test1234 : test1234
		System.out.println(pwEncoder.matches(pw2, encPw2)); // 매치 false // abcd : test1234
		System.out.println("============================");
		System.out.println(pwEncoder.matches(pw2, encPw1));	// 매치 false // abcd : test1234
		
	}
	
}
