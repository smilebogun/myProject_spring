package kr.ezen.pwEncoder.domain;

import java.util.Date;

import lombok.Data;

@Data	// 롬복은 세터게터, 투스트링, 인자, 기본생성자까지 자동으로 생성해줌
public class ReplyDTO {
	private int rno;
	private int bid;
	
	private String r_contents;
	private String replyer;
	private Date r_date;
	private Date update_date;
}
