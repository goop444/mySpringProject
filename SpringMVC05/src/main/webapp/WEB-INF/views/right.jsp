<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="cpath" value="${pageContext.request.contextPath}"/>    

<div class="card" style="min-height: 500px; max-height: 1000px">
	<div class="card-body">
		<h4>BOOK SEARCH</h4>
			<div class="input-group mb-3">
			   <input type="text" id="bookname" class="form-control" placeholder="Search">
			   <div class="input-group-append">
				   <button class="btn btn-success" type="button" id="booksearch">검색</button>
			   </div>
			</div>		
			<div id="bookList" style="overflow: scroll; height: 500px; padding: 10px">
			   	여기에 검색된 결과를 출력하세요.
			</div>
	</div>
</div>