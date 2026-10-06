package com.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.domain.memberDTO;
import com.spring.domain.surveyDTO;
import com.spring.service.MemberService;
import com.spring.service.SurveyServiceImpl;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member")
public class Member_controller {

	@Autowired
	MemberService memberService;
	
	@Autowired
	SurveyServiceImpl surveyService;
	
	//회원가입
	@GetMapping("/register")
	public String join_form() {
		System.out.println("회원가입 페이지로 이동");
	
		return "register";
	}
	
	@PostMapping("/register")
	public String join_recive(HttpServletRequest request) {
		System.out.println("회원가입 페이지에서 데이터 받음");
		
		memberDTO member = new memberDTO();
		member.setLogin_id(request.getParameter("login_id"));
		member.setPassword(request.getParameter("password"));
		member.setNickname(request.getParameter("nickname"));
		
		memberService.memberRegister(member);
		
		
		return "redirect:/";
	}
	
	//로그인
	@GetMapping("/login")
	public String login_member() {
		System.out.println("로그인 페이지로 이동");
	
		return "login_member";
	}
	
	@PostMapping("/login")
	public String login(HttpServletRequest request) {
		System.out.println("로그인 페이지에서 데이터 받음");
		String login_id = (String)request.getParameter("login_id");
		String password = (String)request.getParameter("password");
		
		System.out.println(login_id);
		
		HttpSession session = request.getSession();
		memberDTO member = memberService.memberRead(login_id, password);
		surveyDTO survey = null;
		if(surveyService.surveyRecive(member.getUser_id())!=null) {
			survey = surveyService.surveyRecive(member.getUser_id());
			session.setAttribute("survey", survey);
		}
		
		session.setAttribute("member", member);
		return "redirect:/";
	}
	
	//로그아웃
	@GetMapping("/logout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		
		session.invalidate();
		
		return "redirect:/";
	}
	
	//설문조사
	@GetMapping("/survey")
	public String survey(HttpServletRequest request) {
		System.out.println("설문조사 페이지로 이동");
		
		return "survey";
	}
	
	@PostMapping("/surveyResult")
	public String survey_submit(HttpServletRequest request) {
		System.out.println("설문조사 완료");
		
		//피부유형
		System.out.println(request.getParameter("skin_type"));
		//피부고민
		String[] concern = request.getParameterValues("skin_concern");
		for(String i:concern){
			System.out.println(i);
		}
		System.out.println(request.getParameter("skin_concern_other"));
		//기피성분
		String[] avoid_ingredient = request.getParameterValues("avoid_ingredient");
		for(String i:avoid_ingredient){
			System.out.println(i);
		}
		System.out.println(request.getParameter("avoid_ingredient_other"));
		//민감도
		System.out.println(request.getParameter("sensitivity_a"));
		System.out.println(request.getParameter("sensitivity_b"));
		System.out.println(request.getParameter("sensitivity_c"));
		
		//user_id 추출
		HttpSession session = request.getSession();
		memberDTO member = (memberDTO)session.getAttribute("member"); 
		int user_id = member.getUser_id();
		
		//DTO 저장
		surveyDTO survey = new surveyDTO();
		
		//피부 유형
		survey.setSkin_type(request.getParameter("skin_type"));
		
		//피부 고민
		for(String i : concern) {
			switch(i) {
				case "none":
					survey.setConcern_none(true);
					break;
				case "hydration":
					survey.setHydration(true);
					break;
				case "sensitive":
					survey.setSensitive(true);
					break;
				case "pimple":
					survey.setPimple(true);
					break;
				case "pigmentation":
					survey.setPigmentation(true);
					break;
				case "aging":
					survey.setAging(true);
			}
		}
		
		String concern_other = request.getParameter("skin_concern_other");
		
		if(concern_other.trim()!="") {			
			survey.setSkin_concern_other(concern_other);
		}
		
		//기피성분
		for(String i : avoid_ingredient) {
			switch(i) {
				case "none":
					survey.setAvoid_none(true);
					break;
				case "paraben":
					survey.setParaben(true);
					break;
				case "perfume":
					survey.setPerfume(true);
					break;
				case "ethanol":
					survey.setEthanol(true);
					break;
			}
		}
		
		String avoid_ingredient_other = request.getParameter("avoid_ingredient_other");
		
		if(avoid_ingredient_other.trim()!="") {
			survey.setAvoid_ingredient_other(avoid_ingredient_other);
		}
		 
		//민감도
		int sens_a = Integer.parseInt(request.getParameter("sensitivity_a"));
		int sens_b = Integer.parseInt(request.getParameter("sensitivity_b"));
		int sens_c = Integer.parseInt(request.getParameter("sensitivity_c"));
		
		survey.setSensitivity(sens_a+sens_b+sens_c);
		
		//DB이동
		surveyService.surveySubmit(user_id, survey);
		
		
		//세션 저장
		session.setAttribute("survey", survey);
		
		return "redirect:/";
	}
}
