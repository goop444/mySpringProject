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
    		
    		<div class="col-9">
    			<div class="card">
    				<div class="card-body">
    					<h4 class="card-title">BOARD</h4>
    					<p class="card-text"><button id="register" class="btn btn-sm btn-success">글쓰기</button></p>
    					<div id="board" style="display: block"></div>
    				</div>
    			</div>
    			<div id="write" class="card" style="display: none">
    				<div class="card-body">
    					<h4 class="card-title">BOARD</h4>
    					<p class="card-text">글등록하기</p>
    					<form id="frm">
    						<label>제목 : </label>
    						<input type="text" name="title" class="form-control"/>
    						<label>내용 : </label>
    						<textarea rows="10" name="content" class="form-control"></textarea>
    						<label>작성자 : </label>
    						<input type="text" name="writer" class="form-control"/>
    						<br/>
    						<button type="button" class="btn btn-primary btn-sm" onclick="insert()">등록</button>
    						<button id="reset" type="reset" class="btn btn-warning btn-sm">취소</button>
    					</form>
    				</div>
    			</div>
    		</div>
    		
    	</div>
    </div> 
    <div class="card-footer">
    	빅데이터 분석서비스 개발자과정 (이종은)
    </div>
  </div>
  <script type="text/javascript">
  	$(document).ready(function(){
  		// 글쓰기 버튼이 클릭 됐을 때
  		$("#register").click(function(){
  			//$("#board").css("display","none");
  			if($("#write").css("display")=="none"){
  				$("#write").css("display", "block");
  			} else{
  				$("#write").css("display", "none");	
  			}
  		});
  		
  		// 버튼이 클릭되었을 때 서버통신 : ajax(비동기전송)
  		//$("button").click(function(){
  			loadList();
  		//}); // button
  	}); // jQuery_end
  	function insert(){
  		// 폼에 데이터를 가지고 오기(title, content, writer)
  		var fData=$("#frm").serialize(); // 직렬화:title=111&content=111&writer=111
  		$.ajax({
  			url : "${cpath}/ajaxInsert.do",
  			type : "post",
  			data : fData, // 직렬화:title=111&content=111&writer=111
  			success : loadList,
  			error : function(){ alert("error");}
  		});
  		
  	}
  	function loadList(){
  			$.ajax({
  				url : "${cpath}/ajaxList.do",
  				type : "get",
  				dataType : "json",
  				success : ajaxList,
  				error : function(){alert("error");}
  			}); // ajax
  	}
  	
  	function ajaxList(data){
  		console.log(data);
  		//alert(data);
  		var blist="<table class='table table-hover'>";
  		blist+="<thead>";
  		blist+="<tr>";
  		blist+="<th>번호</th>";
  		blist+="<th>제목</th>";
  		blist+="<th>작성자</th>";
  		blist+="<th>작성일</th>";
  		blist+="<th>조회수</th>";
  		blist+="</tr>";
  		blist+="</thead>";
  		
  		$.each(data, function(index,obj){
  			blist+="<tbody>";
  	  		blist+="<tr>";
  	  		blist+="<td>"+obj.num+"</td>";
  	  		blist+="<td id='t"+obj.num+"'><a href='javascript:contentView("+obj.num+")'>"+obj.title+"</a></td>";
  	  		blist+="<td>"+obj.writer+"</td>";
  	  		blist+="<td>"+obj.indate+"</td>";
  	  		blist+="<td>"+obj.count+"</td>";
  	  		blist+="</tr>";
  	  		// 내용을 보여줄 <tr>을 만들어 준다
  	  		blist+="<tr id='cv"+obj.num+"' style='display:none'>";
  	  		blist+="<td>내용</td>";
  	  		blist+="<td colspan='3'><textarea id='ta"+obj.num+"' rows='7' class='form-control' readonly>"+obj.content+"</textarea></td>";
  	  		blist+="<td>";
  	  		blist+="<span id='ub"+obj.num+"'><button class='btn btn-sm btn-info' onclick='update("+obj.num+")'>수정</button></span>&nbsp;";
  	  		blist+="<span id='db"+obj.num+"'><button class='btn btn-sm btn-warning' onclick='goDelete("+obj.num+")'>삭제</button></span>";
  	  		blist+="</td>";
  	  		blist+="</tr>";
  	  		blist+="</tbody>";
  		});    
  		
  		blist+="</table>";
  		$("#board").html(blist);
  		
  		$("#write").css("display","none");
  		$("#insert").trigger("click");
  		/* // 토글~
  		if($("#board").css("display")=="none"){
  			$("#board").css("display","block");
  			
  		}else{
  			$("#board").css("display","none");
  		} */
  	}
  	function contentView(num){
  		if($("#cv"+num).css("display")=="none"){
  			$("#cv"+num).css("display", "table-row");
  		} else{
  		$("#cv"+num).css("display", "none");
  		}
  	}
  	function update(num){
  		var title=$("#t"+num).text();
  		var titleInput="<input id='nt"+num+"' type='text' class='form-control' value='"+title+"'/>";
  		$("#t"+num).html(titleInput);
  		$("#ta"+num).attr("readonly", false);
  		
  		var newbutton="<button class='btn btn-sm btn-success' onclick='goUpdate("+num+")'>수정하기</button>"
  		$("#ub"+num).html(newbutton);
  	}
  	function goUpdate(num){
  		// 수정 : num, title, content
  		var title=$("#nt"+num).val();
  		var content=$("#ta"+num).val();
  		// 서버로 수정 요청
  		$.ajax({
  			url : "${cpath}/ajaxUpdate.do",
  			type : "post",
  			data : {"num":num,"title":title,"content":content},
  			success : loadList,
  			error : function(){ alert("error");}
  		});
  	}
  	function goDelete(num){
  		if (!confirm("삭제하시겠습니까?")) {
		} else {
  		// 서버로 삭제 요청
  		$.ajax({
  			url : "${cpath}/ajaxDelete.do",
  			type : "get", //@DeleteMapping()
  			data : {"num":num},
  			success : loadList,
  			error : function(){ alert("error");}
  		});
		}
  	}
  	
  </script>	
</body>
</html>