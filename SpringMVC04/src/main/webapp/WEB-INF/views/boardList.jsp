<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/css/style.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>


	<div class="card">
		<div class="card-header">
			<div class="jumbotron jumbotron-fluid">
				<div class="container">
					<h1>Spring MVC Framework</h1>
					<p>MVC, Spring, MySQL, jQuery(Ajax,JSON)</p>
				</div>
			</div>
		</div>
		<div class="card-body">
			<div class="row">
				<div class="col-2">
					<jsp:include page="left.jsp" />
				</div>
				<div class="col-7">
					<div calss="card">
						<div class="card-body">
							<h4 class="card-title">BOARD</h4>
							<p class="card-text">게시판 리스트</p>
							<table class="table table-bordered table-hover">
								<thead>
									<tr>
										<th>번호</th>
										<th>제목</th>
										<th>작성자</th>
										<th>작성일</th>
										<th>조회수</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="vo" items="${list}">
										<tr>
											<td>${vo.num}</td>
											<td><c:if test="${vo.bseq>0 && vo.bdelete == 0}">
													<c:forEach begin="1" end="${vo.blevel}">
														<span style="padding-left: 15px"></span>
													</c:forEach>
													<i class="bi bi-arrow-return-right"></i>
													<a class="get" href="${vo.num}">Re:${vo.title}</a>
												</c:if> <c:if test="${vo.bseq==0 && vo.bdelete == 0}">
													<a class="get" href="${vo.num}">${vo.title}</a>
												</c:if> <c:if test="${vo.bseq>0 && vo.bdelete ==1}">
													<c:forEach begin="1" end="${vo.blevel}">
														<span style="padding-left: 15px"></span>
													</c:forEach>
													<i class="bi bi-arrow-return-right"></i>
													<a href="javascript:goMsg()">Re:삭제된 게시물 입니다.</a>
												</c:if> <c:if test="${vo.bseq==0 && vo.bdelete == 1}">
													<a href="javascript:goMsg()">삭제된 게시물입니다.</a>
												</c:if></td>
											<td>${vo.writer}</td>
											<td><fmt:formatDate value="${vo.indate}"
													pattern="yyyy년MM월dd일" /></td>
											<td>${vo.count}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							
							<!-- 검색 기능 추가 -->
							<form action="${cpath}/list.do" method="post">
								<div class="container">
									<div class="input-group mb-3">
										<div class="input-group-append">

											<select name="type" class="form-control">
												<option value="writer" ${pm.cri.type=='writer' ? 'selected' : ''}>이름</option>
												<option value="title" ${pm.cri.type=='title' ? 'selected' : ''}>제목</option>
												<option value="content" ${pm.cri.type=='content' ? 'selected' : ''}>내용</option>
											</select>
										</div>
											<input type="text" name="keyword" class="form-control" placeholder="Search" value="${pm.cri.keyword}">
										<div class="input-group-append">
											<button class="btn btn-success btn-primary" type="submit">검색</button>
										</div>
									</div>
								</div>
									
							</form>
							<!-- 페이징 처리 -->
							<ul class="pagination justify-content-center">
								<c:if test="${pm.prev==true}">
									<li class="page-item"><a class="page-link"
										href="${pm.startPage-1}">Prev</a></li>
								</c:if>
								<c:forEach var="page" begin="${pm.startPage}"
									end="${pm.endPage}">
									<li class="page-item ${pm.cri.page==page ? 'active':''}"><a
										class="page-link" href="${page}">${page}</a></li>
								</c:forEach>
								<c:if test="${pm.next==true}">
									<li class="page-item"><a class="page-link"
										href="${pm.endPage+1}">Next</a></li>
								</c:if>
							</ul>
							<c:if test="${!empty mvo}">
								<button class="btn btn-primary btn-sm"
									onclick="location.href='${cpath}/register.do'">글쓰기</button>
							</c:if>
						</div>
					</div>
				</div>
				<div class="col-3">
					<jsp:include page="right.jsp" />
				</div>
			</div>

		</div>
		<div class="card-footer">스인개 빅데이터 과정____(피카츄)</div>
	</div>

	<div class="modal" id="myModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">Warning</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">삭제된 게시글 입니다.</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>

			</div>
		</div>
	</div>

	<form id="frm" action="${cpath}/list.do" method="post">
		<input id="page" type="hidden" name="page" value="${pm.cri.page}" />
		<input type="hidden" name="type" value="${pm.cri.type}" />
		<input type="hidden" name="keyword" value="${pm.cri.keyword}" />
		
		<!-- 현재 페이지 값 넣어놓기 -->

	</form>

	<script type="text/javascript">
		$(document).ready(function() {
			$(".page-link").click(function(e) {
				//preventDefault: 태그의 고유 동작(디폴트 값)을 막아주는 역할 
				e.preventDefault();
				var page = $(this).attr("href");
				$("#page").val(page);
				$("#frm").submit();
				//location.href="${cpath}/list.do?page="+page; // 너무 번거로움

			});

			/* 위에 있는 form을 직접 쓰기 위해서 변수에 담기 */
			var frm = $("#frm");
			$(".get").click(function(e) {
				e.preventDefault();
				var num = $(this).attr("href");
				var tag = "<input type='hidden' name='num' value='"+num+"'/>";

				// 클릭이 일어났을때만 input 태그를 추가 해준다.
				frm.append(tag);
				// 페이지 주소를 바꿔줘야 한다.
				frm.attr("action", "${cpath}/get.do");
				frm.attr("method", "get");
				frm.submit();

			});
		});

		function goMsg() {
			$(".modal").modal("show");
		}
	</script>

</body>
</html>