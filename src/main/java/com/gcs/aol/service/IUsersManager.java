package com.gcs.aol.service;

import org.springframework.data.domain.Page;

import com.gcs.aol.entity.Users;
import com.gcs.sysmgr.service.GenericManager;

public interface IUsersManager extends GenericManager<Users>{

	public Page<Users> findAll(Users user,Integer currentPage,Integer pageSize) throws Exception;
}
