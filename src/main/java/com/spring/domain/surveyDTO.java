package com.spring.domain;

public class surveyDTO {
	private int user_id;
	//피부유형
	private String skin_type;				//피부타입
	//피부고민
	private Boolean concern_none = false;	//특별히 없음
	private Boolean hydration = false;		//수분부족
	private Boolean sensitive = false;		//예민,민감성
	private Boolean pimple = false;			//여드름
	private Boolean pigmentation = false;	//색소침작
	private Boolean aging = false;			//노화,탄력저하
	private String skin_concern_other;		//피부고민_기타
	//기피성분
	private Boolean avoid_none = false;		//특별히 없음
	private Boolean paraben = false;		//파라벤
	private Boolean perfume = false;		//인공향료
	private Boolean ethanol = false;		//에탄올
	private String avoid_ingredient_other;	//기피성분_기타
	//민감도
	private int	sensitivity;				//민감도 
	
	public String getSkin_type() {
		return skin_type;
	}
	public void setSkin_type(String skin_type) {
		this.skin_type = skin_type;
	}
	public Boolean getConcern_none() {
		return concern_none;
	}
	public void setConcern_none(Boolean concern_none) {
		this.concern_none = concern_none;
	}
	public Boolean getHydration() {
		return hydration;
	}
	public void setHydration(Boolean hydration) {
		this.hydration = hydration;
	}
	public Boolean getSensitive() {
		return sensitive;
	}
	public void setSensitive(Boolean sensitive) {
		this.sensitive = sensitive;
	}
	public Boolean getPimple() {
		return pimple;
	}
	public void setPimple(Boolean pimple) {
		this.pimple = pimple;
	}
	public Boolean getPigmentation() {
		return pigmentation;
	}
	public void setPigmentation(Boolean pigmentation) {
		this.pigmentation = pigmentation;
	}
	public Boolean getAging() {
		return aging;
	}
	public void setAging(Boolean aging) {
		this.aging = aging;
	}
	public String getSkin_concern_other() {
		return skin_concern_other;
	}
	public void setSkin_concern_other(String skin_concern_other) {
		this.skin_concern_other = skin_concern_other;
	}
	public Boolean getAvoid_none() {
		return avoid_none;
	}
	public void setAvoid_none(Boolean avoid_none) {
		this.avoid_none = avoid_none;
	}
	public Boolean getParaben() {
		return paraben;
	}
	public void setParaben(Boolean paraben) {
		this.paraben = paraben;
	}
	public Boolean getPerfume() {
		return perfume;
	}
	public void setPerfume(Boolean perfume) {
		this.perfume = perfume;
	}
	public Boolean getEthanol() {
		return ethanol;
	}
	public void setEthanol(Boolean ethanol) {
		this.ethanol = ethanol;
	}
	public String getAvoid_ingredient_other() {
		return avoid_ingredient_other;
	}
	public void setAvoid_ingredient_other(String avoid_ingredient_other) {
		this.avoid_ingredient_other = avoid_ingredient_other;
	}
	public int getSensitivity() {
		return sensitivity;
	}
	public void setSensitivity(int sensitivity) {
		this.sensitivity = sensitivity;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	
}
