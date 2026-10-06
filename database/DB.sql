create database Project;
use Project;

CREATE TABLE survey(
	#survey_id INT AUTO_INCREMENT PRIMARY KEY,
	user_id INT,
    skin_type VARCHAR(10),
	concern_none BOOLEAN,
    hydration BOOLEAN,
    `sensitive` BOOLEAN,
    pimple BOOLEAN,
    pigmentation BOOLEAN,
    aging BOOLEAN,
    concern_other TEXT,
    avoid_none BOOLEAN,
    paraben BOOLEAN,
    perfume BOOLEAN,
    ethanol BOOLEAN,
    avoid_ingredient_other TEXT,
    sensitivity INT#,
    #FOREIGN KEY (user_id) REFERENCES member(user_id)
);

create table member(
  user_id INT AUTO_INCREMENT PRIMARY KEY, 			-- 회원 고유 번호
  login_id VARCHAR(15) NOT NULL,					-- 아이디
  password VARCHAR(15) NOT NULL,       				-- 비밀번호
  nickname VARCHAR(50) UNIQUE NOT NULL 			 	-- 닉네임
);