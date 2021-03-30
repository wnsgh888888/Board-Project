<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>게시판 프로젝트</title>

<!-- Custom fonts for this template -->
<link href="../resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="../resources/css/sb-admin-2.min.css" rel="stylesheet">

<!-- Custom styles for this page -->
<link href="../resources/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

</head>


<body id="page-top">
	<div id="wrapper">

		<!-- sidebar -->
		<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

			<!-- Sidebar - Brand -->
			<a class="sidebar-brand d-flex align-items-center justify-content-center" href="/board/list">
				<div class="sidebar-brand-icon rotate-n-15">
					<i class="fa fa-cubes" aria-hidden="true"></i>
				</div>
				<div class="sidebar-brand-text mx-3">pere.kro.kr</div>
			</a>

			<!-- Divider -->
			<hr class="sidebar-divider my-0">

			<sec:authorize access="isAnonymous()">
				<!-- Nav Item - Pages Collapse Menu -->
				<li class="nav-item" id="goCustomLogin" ><a class="nav-link" href="/customLogin">
						<i class="fa fa-share" aria-hidden="true"></i> <span>로그인</span>
					</a></li>
			</sec:authorize>

			<sec:authorize access="isAuthenticated()">
				<li class="nav-item" id="goCustomLogout"><a class="nav-link logoutBtn" href="#" onclick="document.getElementById('logout').submit();">
						<i class="fa fa-reply" aria-hidden="true"></i> <span>로그아웃</span>
					</a></li>
			</sec:authorize>


			<!-- Nav Item - Utilities Collapse Menu -->
			<li class="nav-item" id="goRegister" ><a class="nav-link" href="/register">
					<i class="fa fa-users" aria-hidden="true"></i> <span>회원가입</span>
				</a></li>

			<hr class="sidebar-divider d-none d-md-block">

			<!-- Nav Item - Pages Collapse Menu -->
			<li class="nav-item" id="goList"><a class="nav-link" href="/board/list">
					<i class="fa fa-comments" aria-hidden="true"></i> <span>커뮤니티</span>
				</a></li>

			<!-- Nav Item - Charts -->
			<li class="nav-item" id="goList2"><a class="nav-link" href="/notice/list">
					<i class="fa fa-bullhorn" aria-hidden="true"></i></i> <span>공지사항</span>
				</a></li>

			<!-- Nav Item - Tables -->
			<li class="nav-item" id="goList3"><a class="nav-link" href="/Q&A/list">
					<i class="fa fa-question-circle" aria-hidden="true"></i> <span>Q&A</span>
				</a></li>

			<!-- Divider -->
			<hr class="sidebar-divider d-none d-md-block">

			<!-- Sidebar Toggler (Sidebar) -->
			<div class="text-center d-none d-md-inline">
				<button class="rounded-circle border-0" id="sidebarToggle"></button>
			</div>

		</ul>
		<!-- sidebar -->


		<form id='logout' method='post' action='/includes/header'>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		</form>



		<!-- 수직정렬 시작 -->
		<div class="container-fluid">
			<br>
			<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<script>
$(document).ready( function() {
	
	var url = $(location).attr('href');
	
	if (url.includes("customLogin")){
		$(".nav-item").removeClass("active");
		$("#goCustomLogin").addClass("active");
	}
	else if (url.includes("register")){
		$(".nav-item").removeClass("active");
		$("#goRegister").addClass("active");
	}
	else if (url.includes("board")){
		$(".nav-item").removeClass("active");
		$("#goList").addClass("active");
	}
	else if (url.includes("notice")){
		console.log(url.includes("Q&A"));
		$(".nav-item").removeClass("active");
		$("#goList2").addClass("active");
	}
	else if (url.includes("Q&A")){
		$(".nav-item").removeClass("active");
		$("#goList3").addClass("active");
	}
});
//url에 따라 li에 active를 부여
</script>
