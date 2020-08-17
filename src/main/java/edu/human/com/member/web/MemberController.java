package edu.human.com.member.web;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.human.com.member.service.AuthVO;
import edu.human.com.member.service.EmployerInfoVO;
import edu.human.com.member.service.MemberService;
import edu.human.com.member.service.impl.AuthDAO;
import egovframework.let.utl.sim.service.EgovFileScrty;

@Controller 
/*
 * annotation(에너테이션)
 * @를 이용한 주석, 자바코드에 주석을 달아 특별한 의미를 부여한 것
 * 컴파일러가 특정 오류를 억제하도록 지시하는 것과 같이 프로그램 코드의 일부가 아닌 
 * 프로그램에 관한 데이터를 제공, 코드에 정보를 추가하는 정형화된 방법.
 */

public class MemberController {
	
	@Inject
	private MemberService memberService;
	
	@Inject
	private AuthDAO authDAO;
	
	/** 
	* 관리자관리 중복ID체크(GET)
	* @ResponseBody 에너테이션(Annotation)은 RestAPI방식에서 데이터만 리턴
	*/
	@RequestMapping(value="/com/member/restViewMember.do", method = RequestMethod.GET)
	@ResponseBody
	public int idCheckMember(@RequestParam("EMPLYR_ID") String emplyr_id, Model model) throws Exception{
		int result = 0;
		//viewMember 쿼리를 실행해서 결과가 존재하면 result변수에 1을 입력(아래)
		if(memberService.viewMember(emplyr_id) != null ) {
			result = 1;
		}
		return result;
	}
	
	/** 
	* 관리자관리 삭제(POST)
	*/
	@RequestMapping(value="/com/member/deleteMember.do", method = RequestMethod.POST)
	public String deleteMember(@RequestParam("EMPLYR_ID") String emplyr_id, Model model) throws Exception{
		memberService.deleteMember(emplyr_id);
		return "redirect:/com/member/selectMember.do";
	}
	
	/** 
	* 관리자관리 입력(POST)
	*/
	@RequestMapping(value="/com/member/insertMember.do", method = RequestMethod.POST)
	public String insertMember(EmployerInfoVO vo,Model model) throws Exception{
		String enpassword = EgovFileScrty.encryptPassword(vo.getPASSWORD(), vo.getEMPLYR_ID());
		vo.setPASSWORD(enpassword);
		memberService.insertMember(vo);
		return "redirect:/com/member/selectMember.do";
	}
	
	/** 
	* 관리자관리 입력(GET)
	*/
	@RequestMapping(value="/com/member/insertMember.do", method = RequestMethod.GET)
	public String insertMember(Model model) throws Exception{
		List<AuthVO> authVO = authDAO.selectAuth();
		model.addAttribute("authVO", authVO);
		return "com/member/insert";
	}
	
	/** 
	* 관리자관리 수정(POST)
	*/
	@RequestMapping(value="/com/member/updateMember.do", method = RequestMethod.POST)
	public String updateMember(EmployerInfoVO vo, Model model) throws Exception{
		//PASSWORD 암호화 처리
		if(vo.getPASSWORD() != "") {
			// 1. 입력한 비밀번호를 암호화한다.
			String enpassword = EgovFileScrty.encryptPassword(vo.getPASSWORD(), vo.getEMPLYR_ID());
			vo.setPASSWORD(enpassword);
		}
		memberService.updateMember(vo);
		return "redirect:/com/member/viewMember.do?EMPLYR_ID="+ vo.getEMPLYR_ID();
	}
	
	/** 
	* 관리자관리 수정(GET)
	*/
	@RequestMapping(value="/com/member/updateMember.do", method = RequestMethod.GET)
	public String updateMember(@RequestParam("EMPLYR_ID") String EMPLYR_ID, Model model) throws Exception{
		EmployerInfoVO vo = memberService.viewMember(EMPLYR_ID);
		model.addAttribute("memberVO", vo);
		List<AuthVO> authVO = authDAO.selectAuth();
		model.addAttribute("authVO", authVO);
		return "com/member/update";
	}
	
	/** 
	* 관리자관리 상세보기
	*/
	@RequestMapping(value="/com/member/viewMember.do", method = RequestMethod.GET)
	public String viewMember(@RequestParam("EMPLYR_ID") String EMPLYR_ID, Model model) throws Exception{
		EmployerInfoVO vo = memberService.viewMember(EMPLYR_ID);
		model.addAttribute("memberVO", vo);
		List<AuthVO> authVO = authDAO.selectAuth();
		model.addAttribute("authVO", authVO);
		return "com/member/view";
	}
	
	/** 
	* 관리자관리 목록조회
	*/
	@RequestMapping("/com/member/selectMember.do")
	public String selectMember(Model model) throws Exception{
		List<EmployerInfoVO> memberList = memberService.selectMember();
		model.addAttribute("memberList", memberList);
		return "com/member/list";
	}
}
