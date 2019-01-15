<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>야보자</title>

<!-- Bootstrap Core CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

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
	
</head>

<body>

	<!-- Navigation -->
	<%@ include file="inc/topbar.jsp"%>

	<!-- Menu Bar -->
	<nav class="nav2" style="margin-top: 60px; margin-bottom: 20px;">
		<!-- 메뉴바 -->
		<a href=""><strong>Movie Board</strong></a> <a href=""><strong>Matching
				Board</strong></a> <a href=""><strong>Review Board</strong></a> <a href=""><strong>Q&A
				Board</strong></a> <a href=""><strong>My Page</strong></a>
		<div class="nav-underline"></div>
	</nav>
	
	<!-- mypagesidebar -->
	<%@ include file="inc/mypagesidebar.jsp"%>
	
	<!-- 마이페이지 부분 소스는 여기부터 작성!! -->
	<br><br>
	<div class="layout-container">
		<div id="main">
			<!-- sidebar를 include해준다. -->
			<div class="form">
				<div class="container container-fluid">
				</div>
				<div class="container container-fluid">
				<h2 style="">내 정보</h2>
					<div class="jumbotron jumbotron-fluid">
						<form action="#">
						<table>
						<tr>
							<td rowspan="10" width="150px;" height="170px;" align="center">
								<img alt="프로필 사진" src=${userDto.profile } style="width: 150px;height: 170px;">
							</td>
						</tr>
						<tr align ="center">
								<td rowspan="9" width="100px"></td>
							</tr>
							<tr>
								<th>아이디 ${userDto.id }123
							</tr>
							<tr>
								<th>이름 ${userDto.id }123
							</tr>
							<tr>
								<th>이메일 ${userDto.id }123
							</tr>
							<tr>
								<th>성별 ${userDto.id }123
							</tr>
							<tr>
								<th>연령대 ${userDto.id }123
							</tr>
							<tr>
								<th>주소 ${userDto.id }123
							</tr>
							<tr>
								<th>애용관 ${userDto.id }123
							</tr>
							<tr>
								<th>코인 ${userDto.id }123
							</tr>
						</table>
							<input type="submit" class="btn btn-default pull-right" value="내 정보 수정">
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<hr class="my-4">
	<div class="layout-container">
		<div id="main">
			<!-- sidebar를 include해준다. -->
			<div class="form">
				<div class="container container-fluid">
					<h2>내 게시글</h2>
				</div>
				<div class="container container-fluid">
					<div class="jumbotron jumbotron-fluid">
					<table border="1" class="table table-hover" style="background: white;">
			<thead align="center">
				<tr>
					<th>글번호
					<th>제목
					<th>작성자
					<th>날짜
					<th>조회수
				</tr>
			</thead>
			
			<tbody>
				<tr>
					<td>${boardDto.board_seq }123</td>
					<td>${boardDto.board_title }123</td>
					<td>${boardDto.user_name }123</td>
					<td>${boardDto.board_regdate }123</td>
					<td>${boardDto.view_count }123</td>
				</tr>
				<tr>
					<td>${boardDto.board_seq }123</td>
					<td>${boardDto.board_title }123</td>
					<td>${boardDto.user_name }123</td>
					<td>${boardDto.board_regdate }123</td>
					<td>${boardDto.view_count }123</td>
				</tr>
			</tbody>
		</table>
		<nav aria-label="..." style="text-align: center;">
			<ul class="pagination" id="pasing"><- 1 2 3 4 5 6 7 8 9 -></ul>
		</nav>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Footer -->
	<%@ include file="inc/footer.jsp"%>

</body>

</html>