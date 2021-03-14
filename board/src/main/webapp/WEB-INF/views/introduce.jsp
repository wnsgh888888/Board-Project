<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="./includes/header.jsp"%>


<!-- Page Content -->
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">홈</h1>
	</div>
	<!-- /.col-lg-12 -->

	<!-- /.row -->
	<div class="row">
		
		<div class="col-lg-6">
			<div class="panel panel-default">
				<div class="panel-heading">공지사항</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<table class="table table-striped table-bordered table-hover">		
						<c:forEach var='board' items='${list}'>
							<tr>
							<td><c:out value='${board.bno}' /></td>
								<td>
									<a class='move' href='<c:out value='${board.bno}'/>'>
									<c:out value='${board.title}'/>
									[<c:out value='${board.replyCnt}'/>]
									</a>
								</td>
								<td><c:out value='${board.writer}' /></td>
								<td><fmt:formatDate value='${board.regdate}' pattern='yyyy-MM-dd' /></td>
							</tr>
						</c:forEach>
					</table><!-- /.table-responsive -->
				</div>
				<!-- /.panel-body -->
			</div>
			<!-- /.panel -->
		</div>	
		
		<!-- /.col-lg-6 -->
		<div class="col-lg-6">
			<div class="panel panel-default">
				<div class="panel-heading">자유게시판</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<table class="table table-striped table-bordered table-hover">		
						<c:forEach var='board' items='${list2}'>
							<tr>
								<td><c:out value='${board.bno}' /></td>
								<td>
									<a class='move2' href='<c:out value='${board.bno}'/>'>
									<c:out value='${board.title}'/>
									[<c:out value='${board.replyCnt}'/>]
									</a>
								</td>
								<td><c:out value='${board.writer}' /></td>
								<td><fmt:formatDate value='${board.regdate}' pattern='yyyy-MM-dd' /></td>
							</tr>
						</c:forEach>
					</table><!-- /.table-responsive -->
				</div>
				<!-- /.panel-body -->
			</div>			
		</div>
		<!-- /.col-lg-6 -->
		
		<div class="col-lg-6">
			<div class="panel panel-default">
				<div class="panel-heading">Q&A</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<table class="table table-striped table-bordered table-hover">		
						<c:forEach var='board' items='${list3}'>
							<tr>
								<td><c:out value='${board.bno}' /></td>
								<td>
									<a class='move3' href='<c:out value='${board.bno}'/>'>
									<c:out value='${board.title}'/>
									[<c:out value='${board.replyCnt}'/>]
									</a>
								</td>
								<td><c:out value='${board.writer}' /></td>
								<td><fmt:formatDate value='${board.regdate}' pattern='yyyy-MM-dd' /></td>
							</tr>
						</c:forEach>
					</table><!-- /.table-responsive -->
				</div><!-- /.panel-body -->
			</div><!-- /.panel -->
		</div>
		
		<div class="col-lg-6" style="TEXT-ALIGN:center">
		</div>
		
		<form id='actionForm' action="/board/list" method='get'>
			<input type='hidden' name='pageNum' value='1'>
			<input type='hidden' name='amount' value='10'>
		</form>	

	</div>	<!-- /.row -->
</div><!-- /#page-wrapper -->


<script>
	$(document).ready(function(){
		
		var actionForm = $("#actionForm");
		
		$(".move").on("click", function(e){
			e.preventDefault();
			actionForm.append("<input type='hidden' name='bno' value='" + $(this).attr("href") + "'>");
			actionForm.attr("action","/board/get");
			actionForm.submit();
		});
		
		$(".move2").on("click", function(e){
			e.preventDefault();
			actionForm.append("<input type='hidden' name='bno' value='" + $(this).attr("href") + "'>");
			actionForm.attr("action","/board2/get");
			actionForm.submit();
		});
		
		$(".move3").on("click", function(e){
			e.preventDefault();
			actionForm.append("<input type='hidden' name='bno' value='" + $(this).attr("href") + "'>");
			actionForm.attr("action","/board3/get");
			actionForm.submit();
		});
	});
</script>

<%@include file="./includes/footer.jsp"%>