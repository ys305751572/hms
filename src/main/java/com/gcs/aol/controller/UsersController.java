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

import com.gcs.aol.entity.Users;
import com.gcs.aol.service.IUsersManager;
import com.gcs.aol.service.impl.UsersManagerImpl;
import com.gcs.aol.vo.MsgJsonReturn;
import com.gcs.sysmgr.controller.GenericEntityController;
import com.gcs.sysmgr.vo.PageParameters;
import com.gcs.utils.DataTableReturnObject;
import com.gcs.utils.JSONParam;
import com.gcs.utils.JSONResponse;
import com.gcs.utils.PageUtil;

@RequestMapping("/hms/users/")
@Controller
public class UsersController extends GenericEntityController<Users, Users, UsersManagerImpl> {

	private static final String USER_LIST = "/management/aol/users/usersList";
	private static final String USER_EDIT = "/management/aol/users/usersEdit";
	private static final String USER_DETAIL = "/management/aol/users/usersDetail";

	@Autowired
	private IUsersManager manager;

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

		Users users = manager.queryByPK(id);
		model.addAttribute("users", users);
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

		Users users = manager.queryByPK(id);
		model.addAttribute("users", users);
		return USER_DETAIL;
	}

	/**
	 * 编辑用户信息
	 * 
	 * @param users
	 * @return
	 */
	@RequestMapping(value = "edit", method = RequestMethod.POST)
	public String saveOrUpdate(Users users) {
		manager.save(users);
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
		Page<Users> usersPage = null;
		try {
			Users u = new Users();
			u.setUsername(paramMap.get("username"));
			usersPage = manager.findAll(u, pp.getStart(), pp.getLength());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return successed(new DataTableReturnObject(usersPage.getTotalElements(), usersPage.getTotalElements(),
				pp.getSEcho(), usersPage.getContent()));
	}
}
