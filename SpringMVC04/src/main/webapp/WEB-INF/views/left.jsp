<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />


    <div class="card" style="min-height: 500px; max-height: 1000px">
    	<div class="card-body">
    		<c:if test="${empty mvo}">
    		<h4 class="card-title">GUEST</h4>
    		<p class="card-text">회원님! Welcome</p>
    		<form action="${cpath}/login.do" method="post">
    			<div class="form-group">
    				<label for="username">아이디:</label>
    				<input type="text" class="form-control" name="username" id="username"/>
    				 
    			</div>
    			<div class="form-group">
    				<label for="password">패스워드:</label>
    				<input type="password" class="form-control" name="password" id="password"/>
    				 
    			</div>
    			<button type="submit" class="btn btn-primary btn-sm form-control">로그인</button>
    		</form>
    		</c:if>
    		<c:if test="${!empty mvo }">
    			<h4 class="card-title">${mvo.name}</h4>
    			<p class="card-text">회원님! Welcome</p>
    			<form action="${cpath}/logout.do" method="post">
	    			<button type="submit" class="btn btn-primary btn-sm form-control">로그아웃</button>
    			</form>
    		</c:if>
    	</div>
    </div>