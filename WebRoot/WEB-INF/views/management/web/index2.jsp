<%@ page language="java" contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>合美术馆</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta content="telephone=no" name="format-detection">
<link href="css/app-common.css" rel="stylesheet" type="text/css"/>

</head>
<body>
<div class="wrapper">
	<!-- banner -->
	<div id="mySwipe" class="proimg_wrap">
		<ul>
			<c:forEach items="${adsMap.list}" var="ads">
				<li><a href=""><img src="${contextPath}/${ads.imageUrl}" width="100%" /></a></li>
			</c:forEach>
		</ul>
		<div class="swipedot"></div>
	</div>

	<div class="linksection">
		<ul class="clearfix">
			<li><a href=""><i class="iicon icon1"></i><p>超级课堂</p></a></li>
			<li><a href=""><i class="iicon icon2"></i><p>移动美术馆</p></a></li>
			<li><a href=""><i class="iicon icon3"></i><p>特别活动</p></a></li>
			<li><a href=""><i class="iicon icon4"></i><p>校园大使</p></a></li>
			<li><a href=""><i class="iicon icon5"></i><p>蒲公英计划</p></a></li>
			<li><a href=""><i class="iicon icon6"></i><p>其他</p></a></li>
		</ul>
	</div>

	<div class="listsection">
		<h3 class="rel"><i class="iicon i-dot"></i>超级课堂<a href="" class="abs more">更多 <i class="iicon i-arrow"></i></a></h3>
		<ul class="list_ul">
			<c:forEach items="${map.gj1}" var="gj1">
				<li>
					<a class="clearfix" href="">
						<img class="l-img" src="img/pro.jpg" alt="" />
						<div class="r-part">
							<h4>${gj1.title}</h4>
							<p class="intro">${gj1.content }</p>
							<p class="tr">${gj1.createDate}</p>
						</div>
					</a>
				</li>
			</c:forEach>
		</ul>
	</div>

	<div class="listsection">
		<h3 class="rel"><i class="iicon i-dot"></i>移动美术馆<a href="" class="abs more">更多 &gt;</a></h3>
		<ul class="list_ul">
			<c:forEach items="${map.gj2}" var="gj2">
				<li>
					<a class="clearfix" href="">
						<img class="l-img" src="${contextPath}/${gj2.image}" alt="" />
						<div class="r-part">
							<h4>${gj2.title}</h4>
							<p class="intro">${gj2.content }</p>
							<p class="tr">${gj2.createDate}</p>
						</div>
					</a>
				</li>
			</c:forEach>		
		</ul>
	</div>
	
	
	
	<div class="listsection">
		<h3 class="rel"><i class="iicon i-dot"></i>特别活动<a href="" class="abs more">更多 &gt;</a></h3>
		<ul class="list_ul">
			<c:forEach items="${map.gj3}" var="gj3">
				<li>
					<a class="clearfix" href="">
						<img class="l-img" src="${contextPath}/${gj3.image}" alt="" />
						<div class="r-part">
							<h4>${gj3.title}</h4>
							<p class="intro">${gj3.content }</p>
							<p class="tr">${gj3.createDate}</p>
						</div>
					</a>
				</li>
			</c:forEach>		
		</ul>
	</div>
	
	<div class="listsection">
		<h3 class="rel"><i class="iicon i-dot"></i>校园大使<a href="" class="abs more">更多 &gt;</a></h3>
		<ul class="list_ul">
			<c:forEach items="${map.gj4}" var="gj4">
				<li>
					<a class="clearfix" href="">
						<img class="l-img" src="${contextPath}/${gj4.image}" alt="" />
						<div class="r-part">
							<h4>${gj4.title}</h4>
							<p class="intro">${gj4.content }</p>
							<p class="tr">${gj4.createDate}</p>
						</div>
					</a>
				</li>
			</c:forEach>
		</ul>
	</div>
	
	<div class="listsection">
		<h3 class="rel"><i class="iicon i-dot"></i>蒲公英计划<a href="" class="abs more">更多 &gt;</a></h3>
		<ul class="list_ul">
			<c:forEach items="${map.gj5}" var="gj5">
				<li>
					<a class="clearfix" href="">
						<img class="l-img" src="${contextPath}/${gj5.image}" alt="" />
						<div class="r-part">
							<h4>${gj5.title}</h4>
							<p class="intro">${gj5.content }</p>
							<p class="tr">${gj5.createDate}</p>
						</div>
					</a>
				</li>
			</c:forEach>
		</ul>
	</div>
	
	<div class="listsection">
		<h3 class="rel"><i class="iicon i-dot"></i>其他<a href="" class="abs more">更多 &gt;</a></h3>
		<ul class="list_ul">
			<c:forEach items="${map.gj6}" var="gj6">
				<li>
					<a class="clearfix" href="">
						<img class="l-img" src="${contextPath}/${gj6.image}" alt="" />
						<div class="r-part">
							<h4>${gj6}</h4>
							<p class="intro">${gj6.content }</p>
							<p class="tr">${gj6.createDate}</p>
						</div>
					</a>
				</li>
			</c:forEach>
		</ul>
	</div>
</div>
<script src="js/jquery-1.11.1.min.js"></script>
<script src="js/swipe.js"></script>
<script>
$(function(){
	//banner
	var banner_len = $('.proimg_wrap').find('ul li').length;
	if( banner_len <= 1 ) return;				
	for(var i=0; i < banner_len; i++){
		$('#mySwipe').find('.swipedot').append("<span></span>");
	}		
	$('#mySwipe').find('.swipedot span').eq(0).addClass('current');
	var elem = document.getElementById('mySwipe');
	window.mySwipe = new Swipe(elem, {
	  startSlide: 0,
	  auto: 3000,
	  continuous: true,
	  // disableScroll: true,
	  // stopPropagation: true,
	  callback: function(index, element) {
		$(elem).find('.swipedot span.current').removeClass('current');
		$(elem).find('.swipedot span').eq(index).addClass('current');
	  },
	  transitionEnd: function(index, element) {}
	});
});
</script>
</body>
</html>