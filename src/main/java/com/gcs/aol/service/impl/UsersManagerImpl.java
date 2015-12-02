package com.gcs.aol.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import com.gcs.aol.dao.UsersDAO;
import com.gcs.aol.entity.Users;
import com.gcs.aol.service.IUsersManager;
import com.gcs.sysmgr.service.impl.GenericManagerImpl;

@Service
public class UsersManagerImpl extends GenericManagerImpl<Users, UsersDAO> implements IUsersManager {

	@Autowired
	private UsersDAO dao;

	/**
	 * 查询所有用户
	 * 翻页
	 */
	@Override
	public Page<Users> findAll(final Users user, Integer currentPage, Integer pageSize) throws Exception {
		Page<Users> page = dao.findAll(new Specification<Users>() {
			@Override
			public Predicate toPredicate(Root<Users> root, CriteriaQuery<?> query, CriteriaBuilder build) {
				root = query.from(Users.class);
				List<Predicate> redicates = new ArrayList<Predicate>();

				if (user.getUsername() != null) {
					redicates.add(build.like(root.get("username").as(String.class), "%" + user.getUsername() + "%"));
				}

				Predicate[] ps = new Predicate[redicates.size()];
				return build.and(redicates.toArray(ps));
			}
		}, new PageRequest(currentPage, pageSize, new Sort(Direction.DESC, "id")));
		return page;
	}
}
