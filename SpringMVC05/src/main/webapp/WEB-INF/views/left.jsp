<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="cpath" value="${pageContext.request.contextPath}"/>     
<div class="card" style="min-height: 500px; max-height: 1000px;">
	<div class="row">
		<div class="col-12">
				<div class="card-body">
				    <c:if test="${empty sessionScope.mvo}"><!-- request에서 꺼내올때 requestScope.mvo -->
					
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
				    <c:if test="${!empty sessionScope.mvo}">
				    	<h4 class="card-title">${mvo.name}</h4>
						<p class="card-text">회원님! Welcome</p>
						<form action="${cpath}/logout.do" method="post">
							<button type="submit" class="btn btn-primary btn-sm form-control">로그아웃</button>
						</form>
				    </c:if>
				</div>
		</div>
	</div>
	<div class="row">
		<div class="col-12">
			<div class="card-body">
				<h4>MAP VIEW</h4>
					<div class="input-group mb-3">
					   <input type="text" id="address" class="form-control" placeholder="Address">
					   <div class="input-group-append">
						   <button class="btn btn-success" type="button" id="mapsearch">검색</button>
					   </div>
					</div>		
					<div id="map" style="overflow: scroll; height: 150px; width: 100%">
					   	여기에 검색된 지도를 보기.
					</div>
			</div>
		</div>
	</div>

</div>