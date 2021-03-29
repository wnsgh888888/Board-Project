<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<%@include file="../includes/header.jsp"%>

<div class="card shadow mb-4 text-dark">


	<div class="card-header py-2">
		<h5 class="m-1">새 글 등록</h5>
	</div>
	<!-- 헤드라인 -->


	<div class="card-body">

		<form role='form' action='/board3/register' method='post'>
			<div class='form-group'>
				<label class="font-weight-bold">제목</label>
				<input class='form-control' name='title'>
			</div>

			<div class='form-group'>
				<label class="font-weight-bold">내용</label>
				<textarea class='form-control' rows='9' name='content'></textarea>
			</div>

			<div class='form-group'>
				<label class="font-weight-bold">작성자</label>
				<input class='form-control' name='writer' value='<sec:authentication property="principal.username"/>' readonly='readonly'>
			</div>

			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

			<button type='submit' class='btn btn-primary'>확인</button>
			<button type='button' id='listBtn' class="btn btn-primary">목록</button>
		</form>
	</div>
	<!-- 테이블 바디-->

</div>

<script>
	$(document).ready(function() {
		$("#listBtn").on("click", function() {
			self.location = "/board3/list";
		});
	});
	//리스트 버튼 클릭 시 criteria만을 전송
</script>


<%@include file="../includes/footer.jsp"%>