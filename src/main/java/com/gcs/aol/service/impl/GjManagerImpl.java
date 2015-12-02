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

import com.gcs.aol.dao.GjDAO;
import com.gcs.aol.entity.Gj;
import com.gcs.aol.service.IGjManager;
import com.gcs.sysmgr.service.impl.GenericManagerImpl;

@Service
public class GjManagerImpl extends GenericManagerImpl<Gj, GjDAO> implements IGjManager{

	@Autowired
	private GjDAO dao;
	
	@Override
	public Page<Gj> findAll(final Gj gj, Integer currentPage, Integer pageSize) {
		Page<Gj> page = dao.findAll(new Specification<Gj>() {
			@Override
			public Predicate toPredicate(Root<Gj> root, CriteriaQuery<?> query, CriteriaBuilder build) {
				root = query.from(Gj.class);
				List<Predicate> redicates = new ArrayList<Predicate>();

				if (gj.getTitle() != null) {
					redicates.add(build.like(root.get("title").as(String.class), "%" + gj.getTitle() + "%"));
				}
				if (gj.getContent() != null) {
					redicates.add(build.like(root.get("content").as(String.class), "%" + gj.getContent() + "%"));
				}
				
				Predicate[] ps = new Predicate[redicates.size()];
				return build.and(redicates.toArray(ps));
			}
		}, new PageRequest(currentPage, pageSize, new Sort(Direction.DESC, "id")));
		return page;
	}
}
