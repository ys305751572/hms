package com.gcs.aol.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gcs.aol.entity.Gj;
import com.gcs.aol.service.IGjManager;
import com.gcs.aol.service.impl.GjManagerImpl;
import com.gcs.aol.vo.MsgJsonReturn;
import com.gcs.sysmgr.controller.GenericEntityController;
import com.gcs.sysmgr.vo.PageParameters;
import com.gcs.utils.DataTableReturnObject;
import com.gcs.utils.JSONParam;
import com.gcs.utils.JSONResponse;
import com.gcs.utils.PageUtil;

@RequestMapping("/hms/gj/")
@Controller
public class GjController extends GenericEntityController<Gj, Gj, GjManagerImpl>{

	private static final String USER_LIST = "/management/aol/users/usersList";
	private static final String USER_EDIT = "/management/aol/users/usersEdit";
	private static final String USER_DETAIL = "/management/aol/users/usersDetail";

	@Autowired
	private IGjManager manager;

	/**
	 * 跳转列表页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "listPage", method = RequestMethod.GET)
	public String listPage() {
		return USER_LIST;
	}

	/**
	 * 跳转新增页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "addPage", method = RequestMethod.GET)
	public String addPage() {
		return USER_EDIT;
	}

	/**
	 * 跳转编辑页面
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "editPage", method = RequestMethod.GET)
	public String editPage(@RequestParam("userId") Integer id, Model model) {

		Gj gj = manager.queryByPK(id);
		model.addAttribute("gj", gj);
		return USER_EDIT;
	}

	/**
	 * 跳转到详情页面
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "detailPage", method = RequestMethod.GET)
	public String detailPage(@RequestParam("userId") String id, Model model) {

		Gj gj = manager.queryByPK(id);
		model.addAttribute("gj", gj);
		return USER_DETAIL;
	}

	/**
	 * 编辑用户信息
	 * 
	 * @param users
	 * @return
	 */
	@RequestMapping(value = "edit", method = RequestMethod.POST)
	public String saveOrUpdate(Gj gj) {
		manager.save(gj);
		return USER_LIST;
	}

	/**
	 * 删除用户记录
	 * 
	 * @param userId
	 * @return
	 */
	@RequestMapping(value = "delete", method = RequestMethod.POST)
	@ResponseBody
	public MsgJsonReturn delete(@RequestParam("userId") Integer userId) {
		manager.deleteByPK(userId);
		return new MsgJsonReturn(true, "删除成功");
	}

	@RequestMapping(value = "findAll", method = RequestMethod.POST)
	public JSONResponse findAll(@RequestBody JSONParam[] params) {

		HashMap<String, String> paramMap = (HashMap<String, String>) convertToMap(params);
		PageParameters pp = PageUtil.getParameter(paramMap, "");
		Page<Gj> gjPage = null;
		try {
			Gj u = new Gj();
			u.setTitle(paramMap.get("title"));
			u.setContent(paramMap.get("content"));
			gjPage = manager.findAll(u, pp.getStart(), pp.getLength());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return successed(new DataTableReturnObject(gjPage.getTotalElements(), gjPage.getTotalElements(),
				pp.getSEcho(), gjPage.getContent()));
	}
}
