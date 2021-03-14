<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>            
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>게시판 프로젝트</title>

    <!-- Bootstrap Core CSS -->
    <link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- DataTables CSS -->
    <link href="/resources/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">

    <!-- DataTables Responsive CSS -->
    <link href="/resources/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
	
</head>

<body>
    <div id="wrapper">

        <!-- Navigation -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="/">게시판 프로젝트</a>
            </div>
            <!-- /.navbar-header -->


            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                	<ul class="nav" id="side-menu">                        
 						
 						<li><a href="/"><i class="fa fa-sitemap fa-fw"></i> 홈</a></li>
 						
                    	<sec:authorize access="isAuthenticated()">                        	
                    		<li><a href="/customLogout"><i class="fa fa-sign-out fa-fw"></i> 로그아웃</a></li>
                    	</sec:authorize>                     	
                    	<sec:authorize access="isAnonymous()">                        	
                     		<li><a href="/customLogin"><i class="fa fa-sign-out fa-fw"></i> 로그인</a></li>
                    	</sec:authorize>

						<li><a href="/join"><i class="fa fa-tasks fa-fw"></i> 회원가입</a></li>
 						<li><a href="/board/list"><i class="fa fa-table fa-fw"></i> 공지사항</a></li>
	                    <li><a href="/board2/list"><i class="fa fa-table fa-fw"></i> 자유게시판</a></li>
	                    <li><a href="/board3/list"><i class="fa fa-table fa-fw"></i> Q&A</a></li>
	                    
                    </ul>
                </div>
                <!-- /.sidebar-collapse -->
            </div>
            <!-- /.navbar-static-side -->

        <div id="page-wrapper">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>        
        