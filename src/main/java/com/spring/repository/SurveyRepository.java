package com.spring.repository;

import com.spring.domain.surveyDTO;

public interface SurveyRepository {
	
	void surveySubmit(int user_id, surveyDTO survey);
	surveyDTO surveyRecive(int user_id);
}
