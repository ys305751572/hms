package com.gcs.aol.service;

import org.springframework.data.domain.Page;

import com.gcs.aol.entity.Gj;
import com.gcs.sysmgr.service.GenericManager;

public interface IGjManager extends GenericManager<Gj>{

	public Page<Gj> findAll(Gj gj,Integer currentPage,Integer pageSize);
}
