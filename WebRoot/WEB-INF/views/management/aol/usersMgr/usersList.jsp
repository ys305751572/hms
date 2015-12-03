<%@ page language="java" contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<title>爱奥乐健康云平台</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />

		<%@ include file="/WEB-INF/views/scripts.jsp"%>
		<link rel="stylesheet" type="text/css" href="${contextPath}/jquery-easyui-1.3.3/themes/bootstrap/easyui.css" />
		<link rel="stylesheet" type="text/css" href="${contextPath}/jquery-easyui-1.3.3/themes/icon.css" />
		<link rel="stylesheet" type="text/css" href="${contextPath}/resources/aol/css/aolIcons.css" />
		<script type="text/javascript" src="${contextPath}/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
		<!-- The styles -->
		<style type="text/css">
			body {
				padding-bottom: 10px;
				padding-top: 0px;
			}
			
			.sidebar-nav {
				padding: 9px 0;
			}
			
			#DataTables_Table_0_paginate a {
				margin-left: 5px;
			}
			.dataTables_scroll{
				float: left;
			}
			#DataTables_Table_0_wrapper .row-fluid {
				float: left;
			}
		</style>
		
<script type="text/javascript">		
Date.prototype.format = function(format){
    var o = {
        "M+" :this.getMonth() + 1, // month
        "d+" :this.getDate(), // day
        "h+" :this.getHours(), // hour
        "m+" :this.getMinutes(), // minute
        "s+" :this.getSeconds(), // second
        "q+" :Math.floor((this.getMonth() + 3) / 3), // quarter
        "S" :this.getMilliseconds()
    };
    if (/(y+)/.test(format)) {
        format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    };
    for ( var k in o) {
        if (new RegExp("(" + k + ")").test(format)) {
            format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
        }
    };
    return format;
};
</script>
		<script type="text/javascript">
				$(document).ready(function(){
					var msg = '${msg}';
					if(msg!=""){
						jAlert(msg,'提示');
					}
				});
				var delId = "";
				
				var columns = [ {'text':'姓名','dataIndex':'name','width':'120px'},
							    {'text':'注册时间','dataIndex':'bak5','render':regRender,'width':'120px'}
							    ];
				var arrayObj = [];
				var dataTableObj ;
				$(function() {
					dataTableObj  = new czTools.dataTable({"columns":columns,"render":"aoluserListDataTable",
												"url":"${contextPath}/management/aoluser/getUsersDataList",
												"para":arrayObj,
												"autoIframeHeight":false,
												"showIndex":true,
												"fnComplete":function(){
													 window.parent.resetIframeHeight(dataTableObj.oTable[0].clientHeight+400);
												}});
					searchBtnClick();
					
					$('.form_datetime').datetimepicker({
				        language:  'zh-CN',
				        weekStart: 1,
				        todayBtn:  1,
						autoclose: 1,
						todayHighlight: 1,
						startView: 2,
						forceParse: 0,
				        showMeridian: 1,
				        format:'yyyy-mm-dd',
				        minView:2
				    });
				});
				
				//重新渲染姓名
				function nameRender(row){
					var _ss_name = "";
					var _name = "";
					if(row.name){
						_name = row.name;
					} else {
						_name = "<span style='color:red'>【未填】</span>";
					}
					if(row.remark){
						_ss_name = row.remark+"("+ _name +")"
					} else {
						_ss_name = _name
					}
				
					return '<a href="javascript:viewUserInfo(\''+row.userId+'\');">' + _ss_name + '</a>';
				}
				
				function regRender(row){
					var regtime = "";
					if(row.bak5){
						regtime = new Date(row.bak5).format("yyyy-MM-dd hh:mm:ss")
					}
					return regtime;
				}
				
				function searchBtnClick(){
					var arrayObj = [
						{"name":"usersname","value":$("#usersname").val()},
					];
					dataTableObj.search(arrayObj);
				}
				
				//查看用户信息
			    function viewUserInfo(userId){
					if(!userId){
						if(!dataTableObj.getSelectedRow()){
							jAlert('请选择要查看的用户','提示');
							return;
						}
					}

					$.ajax({
			    		url:'${contextPath}/management/aoluser/sfUserInfo?userId='+dataTableObj.getSelectedRow().userId,
			    		type:'post',
						cache:false,
						success:function(response){
							if(response == "无法查询"){
								jAlert('未找到记录','提示');
							}else{
								window.location.href = "${contextPath}/management/aoluser/viewUserInfo?userId="+dataTableObj.getSelectedRow().userId;
							}
						}
			   		 });
				}
				
				function modifyRemark(){
					if(!dataTableObj.getSelectedRow()){
						jAlert('请选择要修改备注的用户','提示');
						return;
					} else{
						var markvalue = ""
						if(dataTableObj.getSelectedRow().remark){
							markvalue = dataTableObj.getSelectedRow().remark
						}
					
						jPrompt('备注：', markvalue, '修改姓名', function(remarkValue){ 
							if(remarkValue){
								$.post("${contextPath}/management/aoluser/modifyRemark",{"remark":remarkValue, "userId":dataTableObj.getSelectedRow().userId},function(result){
	   								if(result.success){
	   									searchBtnClick();
	   								}else{
	   									jAlert(result.msg);
	   								}
	  							});
							} 
						});
					}
				
				}

				//手动添加设备
				function handAddDevice(){
					if(!dataTableObj.getSelectedRow()){
						jAlert('请选择要添加设备的用户','提示');
						return;
					} else{
						window.location.href = "${contextPath}/management/aoluser/handAddDevice?userId="+dataTableObj.getSelectedRow().userId;
					}

				}
				
		</script>
	</head>
	<body>
		<!--detail start-->
		<div class="row-fluid z-ulnone" id="proList">
			<div class="box span12">			
				<!-- 操作按钮start -->
				<!-- 操作按钮end -->
				
				<div class="box-content" style="margin: -15px;">
					<!-- 搜索条件start -->
					<div class="modal-header" style="float: left;width: 100%; ">
						<form id="form1" name="form1" class="form-horizontal" action="" method="post" enctype="multipart/form-data">
							<table border="0px" style="height: 40px;word-break: keep-all;white-space:nowrap;float: left;">
								<tr>
									<td>姓名：</td>
									<td><input id="usersname" name="usersname" type="text" value="" style="width: 90px; height: 15px;" /></td>
									<td width="10px">&nbsp;</td>
									<td height="40px" align="right">
										<button id="btnSendTop" name="btnSendTop"  style="width:50px;cursor:pointer;"type="button" class="btn btn-primary" onclick="searchBtnClick()"></i>搜索</button>
									</td>
								</tr>
							</table>
						</form>
					</div>
					<!-- 搜索条件end -->

					<!-- 列表start -->
					<div id="aoluserListDataTable" class="z-informa2"></div> 
					<!-- 列表end -->
				</div> 
			</div> 
		</div> 
	</body>
</html>

