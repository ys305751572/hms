package com.gcs.aol.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.gcs.aol.entity.Attach;
import com.gcs.aol.entity.Gj;
import com.gcs.aol.entity.Imageads;
import com.gcs.aol.service.IGjManager;
import com.gcs.aol.service.IImageadsManager;
import com.gcs.aol.service.impl.GjManagerImpl;
import com.gcs.aol.utils.CommonUtils;
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

	private static final String GJ_LIST = "/management/aol/gj/gjList";
	private static final String GJ_EDIT = "/management/aol/gj/gjEdit";
	private static final String GJ_DETAIL = "/management/aol/gj/gjDetail";

	private static final String WEB_INDEX = "/management/web/index2";
	
	@Autowired
	private IGjManager manager;
	
	@Autowired
	private IImageadsManager imageManager;

	/**
	 * 跳转列表页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "listPage", method = RequestMethod.GET)
	public String listPage() {
		return GJ_LIST;
	}

	/**
	 * 跳转新增页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "addPage", method = RequestMethod.GET)
	public String addPage() {
		return GJ_EDIT;
	}

	/**
	 * 跳转编辑页面
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "editPage", method = RequestMethod.GET)
	public String editPage(@RequestParam("gjId") Long id, Model model) {

		Gj gj = manager.queryByPK(id);
		model.addAttribute("gj", gj);
		return GJ_EDIT;
	}

	/**
	 * 跳转到详情页面
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "detailPage", method = RequestMethod.GET)
	public String detailPage(@RequestParam("gjId") Long id, Model model) {

		Gj gj = manager.queryByPK(id);
		model.addAttribute("gj", gj);
		return GJ_DETAIL;
	}

	/**
	 * 编辑用户信息
	 * 
	 * @param users
	 * @return
	 */
	@RequestMapping(value = "edit", method = RequestMethod.POST)
	public String saveOrUpdate(Gj gj,MultipartFile imageFile,HttpServletRequest request) {
		
		Gj _gj = null;
		if(gj.getId() != null) {
			_gj = manager.queryByPK(gj.getId());
		}
		else {
			gj.setCreateDate(new Date());
		}
		
		if(imageFile!=null&&imageFile.getSize()>0){
			String webRoot = request.getSession().getServletContext().getRealPath("");
			Attach attach  = CommonUtils.uploadAttach(imageFile, webRoot, "//upload//dev//",null);
			if(StringUtils.isNotBlank(attach.getAttachId()))
				gj.setImage("//upload//dev//"+attach.getAttachName());
		}
		
		if(_gj != null && StringUtils.isNotBlank(_gj.getImage()) && StringUtils.isBlank(gj.getImage())) {
			gj.setImage(_gj.getImage());
		}
		manager.save(gj);
		return GJ_LIST;
	}

	/**
	 * 删除用户记录
	 * 
	 * @param userId
	 * @return
	 */
	@RequestMapping(value = "delete", method = RequestMethod.POST)
	@ResponseBody
	public MsgJsonReturn delete(@RequestParam("gjId") Long gjId) {
		manager.deleteByPK(gjId);
		return new MsgJsonReturn(true, "删除成功");
	}

	/**
	 * 发布
	 * @param gjId
	 * @return
	 */
	@RequestMapping(value = "publish", method = RequestMethod.GET)
	public String publish(@RequestParam("gjId") Long gjId) {
		Gj gj = manager.queryByPK(gjId);
		gj.setIsList(1);
		manager.save(gj);
		return GJ_LIST;
	}
	
	@RequestMapping(value = "findAll", method = RequestMethod.POST)
	@ResponseBody
	public JSONResponse findAll(@RequestBody JSONParam[] params) {

		HashMap<String, String> paramMap = (HashMap<String, String>) convertToMap(params);
		PageParameters pp = PageUtil.getParameter(paramMap, "");
		Page<Gj> gjPage = null;
		try {
			Gj u = new Gj();
			u.setTitle(paramMap.get("title"));
			u.setContent(paramMap.get("content"));
			u.setType(StringUtils.isNotBlank( paramMap.get("type")) ? Integer.parseInt(paramMap.get("type")) : null );
			u.setIsList(StringUtils.isNotBlank( paramMap.get("isList")) ? Integer.parseInt(paramMap.get("isList")) : null );
			
			gjPage = manager.findAll(u, pp.getStart(), pp.getLength());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return successed(new DataTableReturnObject(gjPage.getTotalElements(), gjPage.getTotalElements(),
				pp.getSEcho(), gjPage.getContent()));
	}
	
	/**
	 * 微信页面访问公教展览列表
	 * @param type
	 * @param gjType
	 * @return
	 */
	@RequestMapping(value = "web/findGjList", method = RequestMethod.GET)
	public String findGjList(@RequestParam(value="type",required = false) Integer type
								  ,@RequestParam(value = "gjType", required = false) Integer gjType
								  ,Model model) {
		
		Map<String,List<Gj>> map = null;
		if(type == 1) {
			// 公教
			map = manager.findGjList(gjType);
		}
		else if (type == 2) {
			// 展览
			map = manager.findZlList();
		}
		model.addAttribute("map", map);
		
		List<Imageads> imagesList = imageManager.findAdsList();
		Map<String,List<Imageads>> adsMap = new HashMap<String,List<Imageads>>();
		adsMap.put("list", imagesList);
		model.addAttribute("adsMap", adsMap);
		
		return WEB_INDEX;
	}
}
