<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<%@include file="../includes/header.jsp"%>

<div class="card shadow mb-4">

	<div class="card-header py-3">
		<h3 class="m-1 text-dark">새 글 등록</h3>
	</div>
	<!-- 헤드라인 -->

	
	<div class="card-body">
	
		<form role='form' action='/board/register' method='post'>
			<div class='form-group'>
				<label>제목</label> <input class='form-control' name='title'>
			</div>

			<div class='form-group'>
				<label>내용</label>
				<textarea class='form-control' rows='3' name='content'></textarea>
			</div>

			<div class='form-group'>
				<label>작성자</label> <input class='form-control' name='writer'
					value='<sec:authentication property="principal.username"/>'
					readonly='readonly'>
			</div>

			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />

			<button class='btn btn-default'>등록</button>
			<button type='reset' class='btn btn-default'>리셋</button>
		</form>
	</div>
	<!-- 테이블 바디-->
</div>

<%@include file="../includes/footer.jsp"%>
