package com.spring.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.stereotype.Repository;

import com.spring.domain.surveyDTO;

@Repository
public class SurveyRepositoryImpl implements SurveyRepository {
	
	DBConnection conn;
	
	@Override
	public void surveySubmit(int user_id, surveyDTO survey) {
		// TODO Auto-generated method stub
		System.out.println(">> surveySubmit() 호출됨");

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DBConnection.getConnection();
			System.out.println(">> DB 연결 성공");

			String SQL = "INSERT INTO survey("
			           + "user_id, skin_type, concern_none, hydration, `sensitive`, "
			           + "pimple, pigmentation, aging, concern_other, "
			           + "avoid_none, paraben, perfume, ethanol, "
			           + "avoid_ingredient_other, sensitivity"
			           + ") VALUES ("
			           + "?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

			pstmt = conn.prepareStatement(SQL);
			System.out.println(">> SQL 준비 완료: " + SQL);
			
			pstmt.setInt(1, user_id);                     			  // user_id
			pstmt.setString(2, survey.getSkin_type());                // skin_type
			pstmt.setBoolean(3, survey.getConcern_none());            // concern_none
			pstmt.setBoolean(4, survey.getHydration());               // hydration
			pstmt.setBoolean(5, survey.getSensitive());               // sensitive
			pstmt.setBoolean(6, survey.getPimple());                  // pimple
			pstmt.setBoolean(7, survey.getPigmentation());            // pigmentation
			pstmt.setBoolean(8, survey.getAging());                   // aging
			pstmt.setString(9, survey.getSkin_concern_other());       // concern_other
			pstmt.setBoolean(10, survey.getAvoid_none());             // avoid_none
			pstmt.setBoolean(11, survey.getParaben());                // paraben
			pstmt.setBoolean(12, survey.getPerfume());                // perfume
			pstmt.setBoolean(13, survey.getEthanol());                // ethanol
			pstmt.setString(14, survey.getAvoid_ingredient_other());  // avoid_ingredient_other
			pstmt.setInt(15, survey.getSensitivity());                // sensitivity

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

	@Override
	public surveyDTO surveyRecive(int user_id) {
	    System.out.println(">> surveyRecive() 호출됨");

	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    surveyDTO survey = null;

	    try {
	        conn = DBConnection.getConnection();
	        System.out.println(">> DB 연결 성공");

	        String SQL = "SELECT * FROM survey WHERE user_id = ?";
	        pstmt = conn.prepareStatement(SQL);
	        pstmt.setInt(1, user_id);

	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            survey = new surveyDTO();
	            survey.setUser_id(user_id);
	            survey.setSkin_type(rs.getString("skin_type"));
	            survey.setConcern_none(rs.getBoolean("concern_none"));
	            survey.setHydration(rs.getBoolean("hydration"));
	            survey.setSensitive(rs.getBoolean("sensitive"));
	            survey.setPimple(rs.getBoolean("pimple"));
	            survey.setPigmentation(rs.getBoolean("pigmentation"));
	            survey.setAging(rs.getBoolean("aging"));
	            survey.setSkin_concern_other(rs.getString("concern_other"));
	            survey.setAvoid_none(rs.getBoolean("avoid_none"));
	            survey.setParaben(rs.getBoolean("paraben"));
	            survey.setPerfume(rs.getBoolean("perfume"));
	            survey.setEthanol(rs.getBoolean("ethanol"));
	            survey.setAvoid_ingredient_other(rs.getString("avoid_ingredient_other"));
	            survey.setSensitivity(rs.getInt("sensitivity"));

	            System.out.println(">> surveyDTO 객체 생성 완료");
	        } else {
	            System.out.println(">> user_id=" + user_id + " 의 survey 데이터 없음");
	            return null;
	        }

	    } catch (Exception e) {
	        System.out.println(">> 예외 발생: surveyRecive()");
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            if (conn != null) conn.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }

	    return survey;
	}


}
