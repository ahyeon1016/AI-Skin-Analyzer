package com.spring.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.stereotype.Repository;

import com.spring.domain.memberDTO;

@Repository
public class MemberRepositoryImpl implements MemberRepository {

	DBConnection conn;

	// CREATE
	@Override
	public void memberRegister(memberDTO member) {
		System.out.println(">> memberRegister() 호출됨");

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DBConnection.getConnection();
			System.out.println(">> DB 연결 성공");

			String SQL = "INSERT INTO member(user_id, login_id, password, nickname) "
					   + "VALUE(NULL, ?, ?, ?)";
			pstmt = conn.prepareStatement(SQL);
			System.out.println(">> SQL 준비 완료: " + SQL);

			pstmt.setString(1, member.getLogin_id());
			pstmt.setString(2, member.getPassword());
			pstmt.setString(3, member.getNickname());
			System.out.println(">> 바인딩 완료: login_id=" + member.getLogin_id() + 
							   ", password=" + member.getPassword() + 
							   ", nickname=" + member.getNickname());

			pstmt.executeUpdate();
			System.out.println(">> INSERT 실행 완료");

		} catch (Exception e) {
			System.out.println(">> 예외 발생: memberRegister()");
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				System.out.println(">> pstmt 닫힘");
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				conn.close();
				System.out.println(">> conn 닫힘");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	// READ
	@Override
	public memberDTO memberRead(String login_id, String password) {
		System.out.println(">> memberRead() 호출됨");

		memberDTO member = new memberDTO();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DBConnection.getConnection();
			System.out.println(">> DB 연결 성공");

			String SQL = "SELECT user_id, nickname FROM member "
					   + "WHERE login_id=? AND password=?";
			pstmt = conn.prepareStatement(SQL);
			System.out.println(">> SQL 준비 완료: " + SQL);

			pstmt.setString(1, login_id);
			pstmt.setString(2, password);
			System.out.println(">> 바인딩 완료: login_id=" + login_id + ", password=" + password);

			rs = pstmt.executeQuery();
			System.out.println(">> SELECT 실행 완료");

			if (rs.next()) {
				member.setUser_id(rs.getInt(1));
				member.setNickname(rs.getString(2));
				System.out.println(">> 결과값 설정 완료: user_id=" + member.getUser_id()
						+ ", nickname=" + member.getNickname());
			} else {
				System.out.println(">> 결과 없음 (로그인 실패 가능)");
			}

		} catch (Exception e) {
			System.out.println(">> 예외 발생: memberRead()");
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				System.out.println(">> rs 닫힘");
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				pstmt.close();
				System.out.println(">> pstmt 닫힘");
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				conn.close();
				System.out.println(">> conn 닫힘");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return member;
	}

}
