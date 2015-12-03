package com.gcs.aol.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.gcs.sysmgr.entity.IdEntity;

/**
 * 公教 / 展示
 * @author yesong
 *
 */
@Table(name = "gj")
@Entity
public class Gj extends IdEntity{

	private static final long serialVersionUID = -5440055022594663213L;

	@Column(name = "title")
	private String title;
	
	@Column(name = "content")
	private String content;
	
	@Column(name = "url")
	private String url;
	
	@Column(name = "image")
	private String image;
	
	@Column(name = "type")
	private Integer type;
	
	@Column(name = "create_date")
	@Temporal(TemporalType.TIMESTAMP)
	private Date createDate;
	
	@Column(name = "show_start_date")
	private String showStartDate;
	
	@Column(name = "show_end_date")
	private String showEndDate;

	@Column(name = "is_list")
	private Integer isList; // 是否发布 -1:未发布 1:已发布
	
	@Column(name = "gj_type")
	private Integer gjType = 0;
	
	public Integer getGjType() {
		return gjType;
	}

	public void setGjType(Integer gjType) {
		this.gjType = gjType;
	}

	public Integer getIsList() {
		return isList;
	}

	public void setIsList(Integer isList) {
		this.isList = isList;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getShowStartDate() {
		return showStartDate;
	}

	public void setShowStartDate(String showStartDate) {
		this.showStartDate = showStartDate;
	}

	public String getShowEndDate() {
		return showEndDate;
	}

	public void setShowEndDate(String showEndDate) {
		this.showEndDate = showEndDate;
	}
}
