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
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
  <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=84fa226a70a16254cdafeea01645d8fd"></script>
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
    		<div class="col-lg-2">
				<jsp:include page="left.jsp"/>    		
    		</div>
    		
    		<div class="col-lg-7">
    			<div class="card">
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
									<td>
									
									
									<c:if test="${vo.bseq>0 && vo.bdelete==0}">
									<c:forEach begin="1" end="${vo.blevel}">
										<span style="padding-left: 10px"></span>
									</c:forEach>
									<i class="bi bi-arrow-return-right"></i>
									<a class="get" href="${vo.num}">RE:${vo.title}</a>
									</c:if>
									<c:if test="${vo.bseq==0 && vo.bdelete==0}">
									<a class="get" href="${vo.num}">${vo.title}</a>
									</c:if>
									
									<c:if test="${vo.bseq>0 && vo.bdelete==1}">
									<c:forEach begin="1" end="${vo.blevel}">
										<span style="padding-left: 10px"></span>
									</c:forEach>
									<i class="bi bi-arrow-return-right"></i>
									<a href="javascript:goMsg()">RE:삭제가 된 게시물 입니다.</a>
									</c:if>
									<c:if test="${vo.bseq==0 && vo.bdelete==1}">
									<a href="javascript:goMsg()">삭제가 된 게시물 입니다.</a>
									</c:if>
									
									
									</td>
									<td>${vo.writer}</td>
									<td><fmt:formatDate value="${vo.indate}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
									<td>${vo.count}</td>
								</tr>
							</c:forEach>
							
							</tbody>
						</table>
						<!-- 검색기능 추가 -->
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
							    <button class="btn btn-success" type="submit">검색</button>
							  </div>
							</div>
						  </div>	
						</form>
						<!-- 페이징 처리 -->
						<ul class="pagination justify-content-center">
						  <c:if test="${pm.prev}">
						  	<li class="page-item"><a class="page-link" href="${pm.startPage-1}">Previous</a></li>
						  </c:if>
						  
						  <c:forEach var="page" begin="${pm.startPage}" end="${pm.endPage}">
						  	<li class="page-item ${pm.cri.page==page ? 'active' : ''}"><a class="page-link" href="${page}">${page}</a></li>
						  </c:forEach>
						  <c:if test="${pm.next}">
						  	<li class="page-item"><a class="page-link" href="${pm.endPage+1}">Next</a></li>
						  </c:if>
						</ul>
						
						<c:if test="${!empty sessionScope.mvo}">
							<button class="btn btn-primary btn-sm" onclick="location.href='${cpath}/register.do'">글쓰기</button>
						</c:if>
    				</div>
    			</div>
    		</div>
    		
    		<div class="col-lg-3">
				<jsp:include page="right.jsp"/>
			</div>
    	</div>
    </div> 
    <div class="card-footer">
    	빅데이터 분석서비스 개발자과정 (이종은)
    </div>
  </div>
  
  <!-- The Modal -->
<div class="modal" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">Modal Heading</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body" style="color: red">
       삭제된 게시물 입니다.
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>
<form id="frm" action="${cpath}/list.do" method="post">
	<input id="page" type="hidden" name="page" value="${pm.cri.page}"/>
	<input type="hidden" name="type" value="${pm.cri.type}"/>
	<input type="hidden" name="keyword" value="${pm.cri.keyword}"/>
</form>
<script type="text/javascript">
	$(document).ready(function(){
		$(".page-link").click(function(e){
			e.preventDefault();
			var page = $(this).attr("href");
			$("#page").val(page);
			$("#frm").submit();
			//location.href="${cpath}/list.do?page="+page;//=><form>
		});
		// 상세보기 a tag클릭시 이동
		var frm=$("#frm");
		$(".get").click(function(e){
			e.preventDefault();
			var num = $(this).attr("href");
			var tag = "<input type='hidden' name='num' value='"+num+"'/>"
			frm.append(tag);
			frm.attr("action", "${cpath}/get.do");
			frm.attr("method", "get");
			frm.submit();
		});
		// 책 검색 버튼이 클릭 되었을 때
		$("#booksearch").click(function(){
			var bookname = $("#bookname").val();
			if(bookname==""){
				alert("책 제목을 입력하세요");
				return false;
			}
			// kakao 책 검색 openAPI(URL-REST Service) 연동하기 : Maps
			// URL :
			// H   : 	743d56f3aace8ae352c045ea23455ea5
			// curl -v -X GET "https://dapi.kakao.com/v3/search/book?target=title" 
			// --data-urlencode "query=미움받을 용기" 
			// -H "Authorization: KakaoAK ${REST_API_KEY}"
			$.ajax({
				url : "https://dapi.kakao.com/v3/search/book?target=title",
				headers : {"Authorization":"KakaoAK 743d56f3aace8ae352c045ea23455ea5"},
				type : "GET",
				data : {"query":bookname},
				dataType : "Json",
				success : bookPrint,
				error : function(){ alert("error");}
			});
			
		}); // #booksearch
		// 주소검색 버튼이 클릭 되었을 때 처리
		$("#mapsearch").click(function(){
			var address=$("#address").val();
			if(address==""){
				alert("주소를 입력하세요");
				return false;
			}
			// URL : 주소 -> 위도, 경도 정보 (지오코딩 - 지도를 이용 정보 추출)
			// H   : 키(REST key)
			// curl -v -X GET "https://dapi.kakao.com/v2/local/search/address.json" \
			//   -H "Authorization: KakaoAK ${REST_API_KEY}" \
			//   --data-urlencode "query=전북 삼성동 100" 
			// fetch()
			$.ajax({ 
				url : "https://dapi.kakao.com/v2/local/search/address.json",
				headers : {"Authorization":"KakaoAK 743d56f3aace8ae352c045ea23455ea5"},
				type : "get",
				data : {"query":address},
				dataType : "Json",
				success : mapView,
				error : function(){ alert("error");}
			});
			
			
		}); //#mapsearch
	}); // jQuery - End
	function mapView(data){
		 //? 광주광역시 서구 경열로20
		console.log(data);
		var address_name=data.documents[0].address_name;
		var building_name=data.documents[0].building_name;
		var x=data.documents[0].x; // 경도
		var y=data.documents[0].y; // 위도
		// 1. 지도를 보여줄 div
		var mapContainer=document.getElementById('map');
		// 2. 지도를 보여주기 위한 option(중심좌표, 지도레벨)
		var mapOption={
			center : new kakao.maps.LatLng(y,x), // Maps OpenAPI
			level  : 2	
		};
		// 3. 지도생성하기
		var map = new kakao.maps.Map(mapContainer,mapOption); // OK
		// 4. 마커가 표시 될 위치지정
		var markerPosition = new kakao.maps.LatLng(y,x);
		// 5. 마커 생성
		var marker = new kakao.maps.Marker({
			position : markerPosition
		});
		// 6. 마커가 지도에 표시
		marker.setMap(map);
		// 7. 마커 위에 보여질 정보 만들기
		var iwContent = "<div style='padding:5px;'>"+address_name+"</div>",iwRemoveable=true;
		// 8. 인포윈도우 생성하기
		var infowindow = new kakao.maps.InfoWindow({
			content : iwContent,
			removable : iwRemoveable
		});
		// 마커에 클릭이벤트를 등록
		kakao.maps.event.addListener(marker, "click", function(){
			infowindow.open(map, marker);
		});
		
		
		//console.log(x);
		//console.log(y);
	}
	
	function goMsg() {
		$(".modal").modal("show");
	}
	function bookPrint(data){
		//alert(data);//?
		console.log(data);
		var blist="<table class='table table-hover'>";
        blist+="<thead>";
        blist+="<tr>";
        blist+="<th>이미지</th>";
        blist+="<th>제목</th>";
        blist+="<th>가격</th>";
        blist+="<th>출판사</th>";
        blist+="</tr>";
        blist+="</thead>";
        blist+="<tbody>";
        $.each(data.documents, function(index,obj){ 
        	var price=obj.price;
        	var publisher=obj.publisher;
        	var title=obj.title;
        	var thumbnail=obj.thumbnail;
        	var url=obj.url;
        	blist+="<tr>";
            blist+="<td><a href='"+url+"'><img src='"+thumbnail+"' width='50px' height='60px'/></a></td>";
            blist+="<td>"+title+"</td>";
            blist+="<td>"+price+"</td>";
            blist+="<td>"+publisher+"</td>";
            blist+="</tr>";
        });
        	
        blist+="</tbody>";
        blist+="</table>";
        $("#bookList").html(blist);
	}
	
	

	
</script>
</body>
</html>