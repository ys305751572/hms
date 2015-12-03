<%@ page language="java" contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<title>爱奥乐健康云平台</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />

	<%@ include file="/WEB-INF/views/scripts.jsp"%>
	<link rel="stylesheet" type="text/css" href="${contextPath}/jquery-easyui-1.3.3/themes/bootstrap/easyui.css" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/jquery-easyui-1.3.3/themes/icon.css" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/aol/css/aolIcons.css" />
	
	
	<script type="text/javascript" src="${contextPath}/resources/js/bootstrap-validation.js" charset="UTF-8"></script>
	<script type="text/javascript" src="${contextPath}/resources/aol/js/uploadPreview.js" charset="UTF-8"></script>
	<script type="text/javascript" src="${contextPath}/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
	
	
	<!-- The styles -->
	<style type="text/css">
		body {
			padding-bottom: 40px;
			font: 12px/1.6 "微软雅黑","宋体";
		}
		.sidebar-nav {
			padding: 9px 0;
		}
		dt {
			font-weight: normal;
			font-size: 18px;
			padding: 4px 0;
			text-indent: 20px;
			color: #000;
		}
		dd {
			font-size: 14px;
			padding: 5px 0;
			margin: 0 40px;
		}
		
		.control-label_1 {
			float: left;
			width: 80px;
			padding-top: 5px;
			text-align: right;
		}
		
		.controls_1 {
			margin-left: 100px;
		}
	</style>
<script type="text/javascript">
	var result;
	try{
		result = eval(${result});
	} catch(e) {
	};

	$(document).ready(function (){
		//提示
		if(result){
			if(result.success){
				//成功
				jAlert(result.msg,'提示',function(){
					window.location.href = '${contextPath}/management/gj/listPage';
				});
			}else{
				//失败
				jAlert(result.msg,'提示',function(){
					history.back(-1);
				});
			}
		};
		$('.form_datetime').datetimepicker({
	        language:  'zh-CN',
	        weekStart: 1,
	        todayBtn:  1,
			autoclose: 1,
			todayHighlight: 1,
			startView: 2,
			forceParse: 0,
	        showMeridian: 1,
	        format:'yyyy-mm-dd hh:ii:ss'
	    });
		
		
		$("#imageFile").uploadPreview({ width: 400, height: 354, imgDiv: "#imgDiv"});
	});
	//1. 简单写法：
	$("form").validation(1);
	
	// 选择公教或者展览事件
	// 选择展览则显示展览时间 ,选择公教则隐藏展览时间
	function changeType() {
		var type = $("#type").val();
		if(type == 2) {
			$("#trShowStartDate").css("display","block");
			$("#trShowEndDate").css("display","block");
			$("#trGjType").css("display","none");
		}
		if(type == 1) {
			$("#trShowStartDate").css("display","none");
			$("#trShowEndDate").css("display","none");
			$("#trGjType").css("display","block");
		}
	}
</script>
</head>
<body>		
<div class="container-fluid">
	<div class="row-fluid">
		<div class="row-fluid z-ulnone">
			<div class="box span12">
				<div class="box-header well z-h2">
					<h2><i class="icon-film"></i> 公教-展览</h2>
					<jsp:include page="/WEB-INF/views/backDiv.jsp" flush="true">
						<jsp:param name="url" value="${contextPath}/hms/gj/listPage"/>
					</jsp:include>
				</div>
				<div class="box-content">
					<form class="form-horizontal" method="post" id="restarteProForm" action="${contextPath}/hms/gj/edit" enctype="multipart/form-data">
					<table>
					  <tr>
					    <td>
					    	<div class="control-group">
								<label class="control-label_1" for="title">标题</label>
								<div class="controls_1">
									<input name="id" type="hidden" value="${gj.id}" />
									<input name="title" style="width:450px;" type="text" placeholder="请输入标题" value="${gj.title}" class="input-large" required="required"  check-type="required" required-message="请输入标题" />
								</div>
							</div>
					    </td>
					    <td rowspan="5">
					    	<div style="width:400px; height:354px; overflow:hidden; margin-top: 0px; margin-bottom: 18px; margin-left: 20px; border:1px solid blue;">
								<div id="imgDiv">
									<c:if test="${!empty gj.image}">
										<img src="${contextPath}/${gj.image}" width="400px" height="354px"  alt="${gj.image}">
									</c:if>
								</div>
							</div>
					    </td>
					  </tr>
					  <tr>
					    <td>
					    	<div class="control-group">
								<label class="control-label_1" for="imageFile">图片</label>
								<div class="controls_1">
									<input id="imageFile" name="imageFile" style="width:450px;" style="width:450px;" type="file" class="input-medium" />
								</div>
							</div>
					    </td>
					  </tr>
					  <tr>
					    <td>
					    	<div class="control-group">
								<label class="control-label_1" for="url">链接</label>
								<div class="controls_1">
									<input name="url" style="width:450px;" type="text" placeholder="请输入链接" value="${gj.url}" class="input-large" required="required"  check-type="required" required-message="请输入链接" />
								</div>
							</div>
					    </td>
					  </tr>
					  <tr>
					    <td>
					    	<div class="control-group">
								<label class="control-label_1" for="content">内容</label>
								<div class="controls_1">
									<textarea style="width:450px;height:150px;" name="content" placeholder="请填写描述" maxlength="1000">${gj.content}</textarea>
								</div>
							</div>
					    </td>
					  </tr>
					  <tr>
						<td>
							<div class="control-group">
								<label class="control-label_1" for="content">是否发布</label>
								<div class="controls_1">
									<select id="isList" name="isList"  style="width: 120px;">
										<option <c:if test="${isList=='1' or isList == ''}">selected="selected" </c:if> value="1">已发布</option>
										<option <c:if test="${isList=='-1'}">selected="selected" </c:if> value="-1">未发布</option>
									</select>
								</div>
							</div>
						</td>
					</tr>
					 <tr>
						<td>
							<div class="control-group">
							<label class="control-label_1" for="content">类型</label>
							<div class="controls_1">
								<select id="type" name="type"  style="width: 120px;" onchange="changeType();">
									<option <c:if test="${type=='1' or type == ''}">selected="selected" </c:if> value="1">公教</option>
									<option <c:if test="${type=='2'}">selected="selected" </c:if> value="2">展览</option>
								</select>
							</div>
						</td>
					</tr>
					<tr id="trGjType" style="display: block;">
						<td>
							<div class="control-group">
							<label class="control-label_1" for="gjType">公教类型</label>
							<div class="controls_1">
								<select id="type" name="gjType"  style="width: 120px;">
									<option <c:if test="${gjType=='1' or gjType == ''}">selected="selected" </c:if> value="1">超级课堂</option>
									<option <c:if test="${gjType=='2'}">selected="selected" </c:if> value="2">移动美术馆</option>
									<option <c:if test="${gjType=='3'}">selected="selected" </c:if> value="3">特别活动</option>
									<option <c:if test="${gjType=='4'}">selected="selected" </c:if> value="4">校园大使</option>
									<option <c:if test="${gjType=='5'}">selected="selected" </c:if> value="5">蒲公英计划</option>
									<option <c:if test="${gjType=='6'}">selected="selected" </c:if> value="6">其他</option>
								</select>
							</div>
						</td>
					</tr>
					<tr id="trShowStartDate" style="display: none;">
						<td>
							<div class="control-group">
								<label class="control-label_1" for="showStartDate">展出开始时间</label>
								<div class="controls_1" >
									<input type="text" name="showStartDate"  id="showStartDate" value="${gj.showStartDate}" readonly  class="input-append date form_datetime"  required="required"  style="width: auto;height: auto;"/>
								</div>
							</div>
						</td>
					</tr>
					<tr id="trShowEndDate" style="display: none;">
						<td>
							<div class="control-group">
								<label class="control-label_1" for="showEndDate">展出结束时间</label>
								<div class="controls_1" >
									<input type="text" name="showEndDate"  id="showEndDate" value="${gj.showEndDate}" readonly  class="input-append date form_datetime"  required="required"  style="width: auto;height: auto;"/>
								</div>
							</div>
						</td>
					</tr>
					  <tr>
						<td>
							<div class="control-group">
								<label class="control-label" for="btnSave"></label>
								<div style="margin-left: 300px;">
									<button id="btnSave" name="btnSave" type="submit" class="btn btn-primary">保存</button>
								</div>
							</div>
						</td>
					  </tr>
					</table>
					</form>
				</div>
				
			</div>
		</div>
	</div>
</div>


</body>
</html>		
