package com.gcs.aol.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.gcs.utils.DateUtil;

@Service
public class GjManagerImpl extends GenericManagerImpl<Gj, GjDAO> implements IGjManager{

	@Autowired
	private GjDAO dao;
	
	@Override
	public Page<Gj> findAll(final Gj gj, Integer currentPage, Integer pageSize) {
		Page<Gj> page = dao.findAll(new Specification<Gj>() {
			@Override
			public Predicate toPredicate(Root<Gj> root, CriteriaQuery<?> query, CriteriaBuilder build) {
				List<Predicate> redicates = new ArrayList<Predicate>();

				if (gj.getTitle() != null) {
					redicates.add(build.like(root.get("title").as(String.class), "%" + gj.getTitle() + "%"));
				}
				if (gj.getContent() != null) {
					redicates.add(build.like(root.get("content").as(String.class), "%" + gj.getContent() + "%"));
				}
				if (gj.getIsList() != null) {
					redicates.add(build.equal(root.get("isList").as(Integer.class), gj.getIsList()));
				}
				if (gj.getType() != null) {
					redicates.add(build.equal(root.get("type").as(Integer.class), gj.getType()));
				}
				Predicate[] ps = new Predicate[redicates.size()];
				return build.and(redicates.toArray(ps));
			}
		}, new PageRequest(currentPage, pageSize, new Sort(Direction.DESC, "id")));
		return page;
	}

	@Override
	public Map<String, List<Gj>> findGjList(Integer gjType) {
		Map<String,List<Gj>> map = null;
		if(gjType != null) {
			List<Gj> gjList = queryByProperty("type", 1, "id", false);
			map = groupByGjType(gjList);
		}
		else {
			List<Gj> gjList = queryByProperty("gjType", gjType, "id", false);
			map = new HashMap<String,List<Gj>>();
			map.put("list", gjList);
		}
		return map;
	}
	
	
	private Map<String, List<Gj>> groupByGjType(List<Gj> gjList) {
		Map<String,List<Gj>> map = new HashMap<String,List<Gj>>();
		for (Gj gj : gjList) {
			List<Gj> list = map.get(gj.getGjType().intValue() + "");
			if(list != null && list.size() > 0) {
				list.add(gj);
			}
			else {
				list = new ArrayList<Gj>();
				list.add(gj);
				map.put("" + gj.getGjType().intValue(), list);
			}
		}
		return map;
	}

	@Override
	public Map<String, List<Gj>> findZlList() {
		
		List<Gj> gjList = queryByProperty("type", 2, "id", false);
		Map<String, List<Gj>> map = groupByShowDate(gjList);
		return map;
	}

	private Map<String, List<Gj>> groupByShowDate(List<Gj> gjList) {
		
		return null;
	}
}
