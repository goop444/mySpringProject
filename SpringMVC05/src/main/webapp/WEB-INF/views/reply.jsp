<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    					<p class="card-text">답글쓰기</p>
    					<form action="${cpath}/reply.do" method="post">
    						<input type="hidden" name="username" value="${mvo.username}"/>
    						<input type="hidden" name="num" value="${pvo.num}"/>
    						<input type="hidden" name="page" value="${cri.page}"/>
    						<input type="hidden" name="type" value="${cri.type}"/>
    						<input type="hidden" name="keyword" value="${cri.keyword}"/>
    						
    						<div class="form-group">
    							<label for="title">제목:</label>
    							<input type="text" id="title" name="title" class="form-control" value="${pvo.title}"/>
    						</div>
    						<div class="form-group">
    							<label for="content">답변:</label>
    							<textarea rows="10" class="form-control" name="content" id="content"></textarea>
    						</div>
    						<div class="form-group">
    							<label for="writer">작성자:</label>
    							<input type="text" id="writer" name="writer" class="form-control" value="${mvo.name}" readonly="readonly"/>
    						</div>
    						<button type="button" class="btn btn-primary btn-sm" onclick="location.href='${cpath}/list.do'">목록</button>
    						<button type="submit" class="btn btn-primary btn-sm">등록</button>
    						<button type="reset" class="btn btn-primary btn-sm">취소</button>
    					</form>
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

</body>
</html>