package com.spring.repository;

import com.spring.domain.memberDTO;

public interface MemberRepository {
	void memberRegister(memberDTO member);
	memberDTO memberRead(String login_id, String password);
}
