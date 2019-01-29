<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> --%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>야보자</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Bootstrap Core CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Theme CSS -->
<link href="css/clean-blog.min.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<link
	href='https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic'
	rel='stylesheet' type='text/css'>
<link
	href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800'
	rel='stylesheet' type='text/css'>



<!-- Menu Bar -->
<link href="css/menubar.css" rel="stylesheet">
<!-- Content -->
<link href="css/index_content.css" rel="stylesheet">
<!-- jQuery -->
<script src="vendor/jquery/jquery.min.js"></script>


<!-- 별로 표시하기 -->
		<script>
		
		window.onload = function () {
			 
			 var innerHtml="";
				var x=${dto.rating};
				x=x/2;

				for(var i =0 ; i < 5; i ++) {  

				  if( i <x-1) {

				   innerHtml  +=   "<i class='glyphicon glyphicon-star'></i>" ;  

				  }else{

				     innerHtml  +=  "<i class='glyphicon glyphicon-star-empty'></i>" ;

				 }

				} 

				$('#myspan').html(innerHtml);
			}			
		
		</script>
		
<!-- 별로 표시하기 끝-->

<style>
.actorimage li{display:inline-block; width:160px; height:220px;}
.actorimage li dl{width:160px; height:60px;}
.actorimage li .tx_people{width:160px; height:20px;}
.actorimage li img{width:160px; height:200px;}
.actorimage li .staff_dir{height:40px; margin-bottom:60px;}
</style>




</head>

<body>


	<!-- Navigation -->
	<%@ include file="../inc/topbar.jsp"%>


	<!-- Menu Bar -->
	<nav class="nav2" style="margin-top: 60px; margin-bottom: 20px;">
		<!-- 메뉴바 -->
		<a href=""><strong>Movie Board</strong></a> <a href=""><strong>Matching
				Board</strong></a> <a href=""><strong>Review Board</strong></a> <a href=""><strong>Q&A
				Board</strong></a> <a href=""><strong>My Page</strong></a>
		<div class="nav-underline"></div>
	</nav>

	<!-- mypagesidebar -->
	<%@ include file="../inc/moviesidebar2.jsp"%>

	<!-- 마이페이지 부분 소스는 여기부터 작성!! -->
	</br>
	</br>
	<div class="container">
		
		<h1>${dto.movieTitle }</h1>
		

		
		</br>

		<div align="left">
			<table border="1" class="table table-hover" style="font-size:30px;">
				<tr>
					<td rowspan="5" style="width: 168px;"><img
						src="${dto.imgUrl }" width="300" height="450"></td>
					<td>장르 : ${dto.genre } | 평점 : ${dto.rating } <span id="myspan"></span></td>
				</tr>

				<tr>
					<td>상영시간 : ${dto.time } | ${dto.pupDate } 개봉</td>
				</tr>
				
				<tr>
					<td>감독 : ${dto.director}</td>
				</tr>
				<tr>
					<td>출연 : ${dto.actor}</td>
				</tr>

			</table>
		</div>
		<div align="right">
			<input type="button" name="btn1" value="매칭하러가기" class="btn btn-default" />
		</div>
		</br> </br>
		
		${content }

		<div>
			<h1>한줄 평</h1>
		</div>

		<div>
			<form action="" method="post">
				<input type="hidden" name="" value="" />
				<table border="1" class="table table-hover">
					<tr>

						<td><textarea rows="5" cols="120" name=""></textarea></td>
						<td colspan="2"><input type="submit" value="작성" class= "btn btn-default"  style="height:110px;"></td>
					</tr>

				</table>
			</form>
		</div>
		<div>
			<c:choose>
				<c:when test="${empty list  }">
					<h3>작성된 댓글이 없습니다.</h3>
				</c:when>
				<c:otherwise>
					<table>
						<tr>
							<th>id</th>
							<th>날짜</th>
							<th>이름</th>
							<th>내용</th>
						</tr>

						<c:forEach var="dto" items="${list }">
							<tr>
								<td>${dto.id }</td>
								<td>${dto.date }</td>
								<td>${dto.name }</td>
								<td>${dto.content }</td>
							</tr>
						</c:forEach>
					</table>
				</c:otherwise>
			</c:choose>

		</div>
	</div>

	<!-- Footer -->
	<%@ include file="../inc/footer.jsp"%>



</body>

</html>