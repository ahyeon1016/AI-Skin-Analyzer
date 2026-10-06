package com.spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.domain.surveyDTO;
import com.spring.repository.SurveyRepositoryImpl;

@Service
public class SurveyServiceImpl implements SurveyService {
	
	@Autowired
	SurveyRepositoryImpl surveyRepository;
	
	@Override
	public void surveySubmit(int user_id, surveyDTO survey) {
		// TODO Auto-generated method stub
		System.out.println("SurveyRepository로 이동");
		surveyRepository.surveySubmit(user_id, survey);
	}

	@Override
	public surveyDTO surveyRecive(int user_id) {
		return surveyRepository.surveyRecive(user_id);
	}

}
