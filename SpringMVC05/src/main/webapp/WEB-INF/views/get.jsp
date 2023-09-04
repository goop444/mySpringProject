<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 줄바꿈 바인딩 -->
<% pageContext.setAttribute("newLineChar", "\n"); %> 
<c:set var="cpath" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="resources/css/style.css">
  <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
 
  <div class="card">
    <div class="card-header">
    	<div class="jumbotron jumbotron-fluid">
		  <div class="container">
		    <h1>Spring MVC Framework</h1>
		    <p>MVC, Spring, MySQL, JQuery(Ajax,JSON)</p>
		  </div>
		</div>
    </div>
    <div class="card-body">
    	<div class="row">
    		<div class="col-2">
				<jsp:include page="left.jsp"/>    		
    		</div>
    		
    		<div class="col-7">
    			<div class="card">
    				<div class="card-body">
    					<h4 class="card-title">BOARD</h4>
    					<p class="card-text">상세보기</p>
    					<table class="table table-bordered">
    							<tr>
    								<td style="width: 100px">제목</td>
    								<td>${vo.title}</td>
    								
    							</tr>
    							<tr>
    								<td>내용</td>
    								<td>${fn:replace(vo.content, newLineChar, "<br/>") }</td>
    								
    							</tr>
    							<tr>
    								<td>작성자</td>
    								<td>${vo.writer}</td>
    								
    							</tr>
    							<tr>
    								<td>작성일</td>
    								<td><fmt:formatDate value="${vo.indate}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
    								
    							</tr>
    							<tr>
    								<td colspan="2" style="text-align: center;">
    									<button data-btn="list" class="btn btn-primary btn-sm">목록</button>
    									<c:if test="${!empty mvo}">
    										<c:if test="${vo.username eq mvo.username}">
		    									<button data-btn="modify" class="btn btn-primary btn-sm">수정</button>
		    									<button data-btn="remove" class="btn btn-primary btn-sm">삭제</button>
    										</c:if>
	    									<button data-btn="reply" class="btn btn-primary btn-sm">답글</button>
    									</c:if>
    								</td>
    							</tr>
    					</table>
    				</div>
    			</div>
    		</div>
    		
    		<div class="col-3">
				<jsp:include page="right.jsp"/>
			</div>
    	</div>
    </div> 
    <div class="card-footer">
    	빅데이터 분석서비스 개발자과정 (이종은)
    </div>
  </div>
  <form id="frm">
  	<input type="hidden" name="num" value="${vo.num}"/> <!-- 데이터 담아 보내기 -->
  	<input type="hidden" name="page" value="${cri.page}"/> <!-- 데이터 담아 보내기 -->
  	<input type="hidden" name="type" value="${cri.type}"/> <!-- 데이터 담아 보내기 -->
  	<input type="hidden" name="keyword" value="${cri.keyword}"/> <!-- 데이터 담아 보내기 -->
    
  </form>	
<script type="text/javascript">
	//jQuery(자바스크립트 라이브러리:API(.js)) : http://jquery.com : $.ajax, fetch(ajax)
	$(document).ready(function(){
		// 버튼이 선택 되면 ~~
		$("button").click(function(){
			var frm = $("#frm");
			var data = $(this).data("btn"); // data-btn
			if(data=="list"){
				//location.href="${cpath}/list.do"; // get 방식 이동
				frm.attr("action","${cpath}/list.do"); // 인자 1개면 get, 2개면 set
				frm.attr("method","post");
			} else if(data=="modify") {
				frm.attr("action","${cpath}/modify.do"); // 인자 1개면 get, 2개면 set
				frm.attr("method","get");
			} else if(data=="remove") {
				frm.attr("action","${cpath}/remove.do");
				frm.attr("method","get");
			} else if(data=="reply") {
				frm.attr("action","${cpath}/reply.do");
				frm.attr("method","get");
			}
			frm.submit();
		});
	});
</script>
</body>
</html>