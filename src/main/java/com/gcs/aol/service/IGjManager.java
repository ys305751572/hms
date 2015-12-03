package com.gcs.aol.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.gcs.aol.entity.Gj;
import com.gcs.sysmgr.service.GenericManager;

public interface IGjManager extends GenericManager<Gj>{

	public Page<Gj> findAll(Gj gj,Integer currentPage,Integer pageSize);
	
	Map<String,List<Gj>> findGjList(Integer gjType);
	
	Map<String,List<Gj>> findZlList();
}
