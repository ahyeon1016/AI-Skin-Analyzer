package com.spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.domain.memberDTO;
import com.spring.repository.MemberRepository;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberRepository memberRepository;
	
	@Override
	public void memberRegister(memberDTO member) {
		// TODO Auto-generated method stub}
		
		memberRepository.memberRegister(member);
	}

	@Override
	public memberDTO memberRead(String login_id, String password) {
		// TODO Auto-generated method stub
		return memberRepository.memberRead(login_id, password);
	}
}
