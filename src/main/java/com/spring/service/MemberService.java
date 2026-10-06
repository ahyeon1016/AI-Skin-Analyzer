package com.spring.service;

import com.spring.domain.memberDTO;

public interface MemberService {
	
	void memberRegister(memberDTO member);
	memberDTO memberRead(String login_id, String password);
	
}
