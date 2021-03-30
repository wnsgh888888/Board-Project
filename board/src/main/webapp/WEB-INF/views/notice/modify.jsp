<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<%@include file="../includes/header.jsp"%>

<div class="card shadow mb-4 text-dark">

	<div class="card-header py-2">
		<h5 class="m-1 text-dark">해당 글 수정</h5>
	</div>
	<!-- 헤드라인 -->


	<div class="card-body">
		<form role='form' action='/notice/modify' method='post'>


			<div class='form-group'>
				<label class="font-weight-bold">번호</label>
				<input class='form-control' name='bno' value='${board.bno}' readonly='readonly'>
			</div>

			<div class='form-group'>
				<label class="font-weight-bold">제목</label>
				<input class='form-control' name='title' value='${board.title}'>
			</div>

			<div class='form-group'>
				<label class="font-weight-bold">내용</label>
				<textarea class='form-control' rows='9' name='content'>${board.content}</textarea>
			</div>

			<div class='form-group'>
				<label class="font-weight-bold">작성자</label>
				<input class='form-control' name='writer' value='${board.writer}' readonly='readonly'>
			</div>


			<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
			<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
			<input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'>
			<input type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

			<sec:authentication property="principal" var="pinfo" />
			<sec:authorize access="isAuthenticated()">
				<c:if test="${pinfo.username eq board.writer}">
					<button type='submit' data-oper='modify' class='btn btn-primary'>확인</button>
				</c:if>
			</sec:authorize>

			<button type='submit' data-oper='list' class='btn btn-primary'>목록</button>


		</form>
	</div>
	<!-- 테이블 바디-->
</div>
<!-- 게시글 -->


<script>
	$(document).ready(function() {
		var formObj = $("form");

		$("button[data-oper='list']").on("click", function(e) {
			e.preventDefault();

			formObj.attr("action", "/notice/list").attr("method", "get");

			var pageNumTag = $("input[name='pageNum']").clone();
			var amountTag = $("input[name='amount']").clone();
			var keywordTag = $("input[name='keyword']").clone();
			var typeTag = $("input[name='type']").clone();
		
			formObj.empty();
			formObj.append(pageNumTag);
			formObj.append(amountTag);
			formObj.append(keywordTag);
			formObj.append(typeTag);

			formObj.submit();
		});
	});
</script>



<%@include file="../includes/footer.jsp"%>
