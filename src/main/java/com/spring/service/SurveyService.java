package com.spring.service;

import com.spring.domain.surveyDTO;

public interface SurveyService {
	
	void surveySubmit(int user_id, surveyDTO survey);
	surveyDTO surveyRecive(int user_id);
}
